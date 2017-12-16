require "bits_dealer/commands/configure"

module BitsDealer
  class REPL
    include BitsDealer::Configure

    COMMAND_LIST = [
      'help', 'configure', 'exit', 'quit', 'reset',
    ].sort

    def initialize(options={})
      @options = options

      Readline.completion_append_character = " "
      Readline.completion_proc = proc { |s| COMMAND_LIST.grep(/^#{Regexp.escape(s)}/) }
    end

    def start
      display "Hello there! ready to rock in bitso."

      if BitsDealer::Config.needs_configuration?
        display "\nIMPORTANT!!!\nBitsDealer is not configured, to start using it type 'configure'\n", :red
      else
        password = Readline.readline("\nConfiguration detected, input your password to load it:\n> ", true)
        @config = Config.new(password)
      end

      while command = Readline.readline("> ", true)
        case command
        when "help"
          display "Soon, I will have help for you."
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

    def display(message, *args)
      formatted_message = Rainbow(message)

      args.each do |key|
        formatted_message = formatted_message.send key
      end

      puts formatted_message
    end
  end
end

