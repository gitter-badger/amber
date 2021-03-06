require "icr"
require "cli"

module Amber::CLI
  class MainCommand < ::Cli::Supercommand
    command "c", aliased: "console"

    class Console < ::Cli::Command
      command_name "console"

      class Options
        bool ["-d", "--debug"], desc: "# Runs console in debug mode.", default: false
      end

      def run
        libs = [
          %(require "amber"),
          %(require "./src/controllers/application_controller"),
          %(require "./src/controllers/*"),
          %(require "./src/models/*"),
          %(require "./src/mailers/*"),
          %(require "./src/views/*"),
        ]
        code = libs.join ';'
        Icr::Console.new(options.d?).start(code)
      end

      class Help
        caption "# Starts Amber console"
      end
    end
  end
end
