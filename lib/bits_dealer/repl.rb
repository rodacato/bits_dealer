require "bits_dealer/commands/balance"
require "bits_dealer/commands/configure"
require "bits_dealer/commands/help"

module BitsDealer
  class REPL
    include BitsDealer::Balance
    include BitsDealer::Configure
    include BitsDealer::Help

    def initialize(options={})
      @options = options
    end

    def start
      ensure_configuration

      display "Hello there! ready to rock in bitso."

      while command = ask("> ")
        case command
        when "help", '?'
          help
        when "exit", "quit"
          break
        else
          process(command)
        end
      end

      display "Goodbye, I hope you made money!\n"
    end

    def process(command)
      begin
        result = eval(command)
        display "=> #{result}"
      rescue SyntaxError => e
        @last_error = e
        display "Oops, seems to have been some error."
      rescue NameError => e
        @last_error = e
        display "Oops, you tried to use a method or variable that doesn't exist."
      rescue ArgumentError => e
        @last_error = e
        display "Oops, you tried to use a method without the right parameters."
      rescue => e
        @last_error = e
        display "Opps, didnt worked, something bad happened."
      end
    end

    private

    def ensure_configuration
      if BitsDealer::Config.needs_configuration?
        display "\nIMPORTANT!!!\nBitsDealer is not configured, to start using it type 'configure'\n", :red
      else
        password = buzz("Configuration detected, input your password to load it:", show_input: false)
        @config = Config.new(password)
        display "Configuration loaded.\n\n", :green
      end
    end

    def display(message, *args)
      formatted_message = message

      args.each do |key|
        formatted_message = "<%= color('#{formatted_message}', #{key.upcase}) %>"
      end

      say formatted_message
    end

    def buzz(message, prompt: true, show_input: true)
      message = "\n#{message}\n<%= color('> ', BOLD) %>" if prompt

      ask(message) do |q| 
        q.echo = show_input
      end
    end
  end
end

