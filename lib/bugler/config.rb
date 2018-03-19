# frozen_string_literal: true

module Bugler
  module Config
    HELP_TEXT =
  %{Bugler - Sleek Static Site Generator
  Usage:
    bugler init <NAME> - Generate new blank website
}
    ERROR_EXEC_UNRECOGNIZED = "Error: Command not recognized."
    ERROR_INIT_NO_NAME = "Error: Please provide a name for your app"
    ERROR_INIT_ARGV = "Error: Provided argv argument must be an array"
    ERROR_SERVER_NOT_A_PROJECT = "Error: Current directory is not a bugler project. Try 'bugler init <NAME>'"

    SOURCE_DIRNAME = "src"

    DEFAULT_PORT = 8080
  end
end
