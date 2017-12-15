module BitsDealer
  class REPL
    def initialize(options={})
      @options = options
    end

    def start
      display "Hello there! ready to rock in bitso."

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
      rescue SyntaxError
        display "Oops, seems to have been some error."
      rescue NameError
        display "Oops, you tried to use a method or variable that doesn't exist."
      rescue ArgumentError
        display "Oops, you tried to use a method without the right parameters"
      end
    end

    def display(message)
      puts message
    end
  end
end

