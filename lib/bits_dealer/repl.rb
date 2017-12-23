require "bits_dealer/commands/balance"
require "bits_dealer/commands/books"
require "bits_dealer/commands/cancel_order"
require "bits_dealer/commands/configure"
require "bits_dealer/commands/help"
require "bits_dealer/commands/new_order"
require "bits_dealer/commands/open_orders"
require "bits_dealer/commands/tickers"

require "bits_dealer/helper"

require 'readline'

module BitsDealer
  class REPL
    include BitsDealer::Balance
    include BitsDealer::Books
    include BitsDealer::CancelOrder
    include BitsDealer::Configure
    include BitsDealer::Help
    include BitsDealer::NewOrder
    include BitsDealer::OpenOrders
    include BitsDealer::Tickers

    def initialize(options={})
      @options = options
    end

    def start
      ensure_configuration

      prompt.say "Hello there! ready to rock in bitso."

      while command = Readline.readline("> ")
        case command
        when "help", '?'
          help
        when "exit", "quit"
          break
        else
          process(command)
        end
      end

      prompt.say "Goodbye, I hope you made money!\n"
    end

    def process(command)
      begin
        result = eval(command)
        prompt.say "=> #{result}\n" if result
      rescue TTY::Reader::InputInterrupt => e
        prompt.warn "\nGot it, lets do something else."
      rescue SyntaxError => e
        @last_error = e
        prompt.warn "Oops, seems to have been some error."
      rescue NameError => e
        @last_error = e
        prompt.warn "Oops, you tried to use a method or variable that doesn't exist."
      rescue ArgumentError => e
        @last_error = e
        prompt.warn "Oops, you tried to use a method without the right parameters."
      rescue => e
        @last_error = e
        prompt.warn "Opps, didnt worked, something bad happened."
      end
    end

    private

    def prompt
      @prompt ||= ::TTY::Prompt.new(enable_color: true, prefix: '> ', track_history: false)
    end

    def formatter
      @formatter ||= Pastel.new
    end

    def helper
      @helper ||= BitsDealer::Helper.new(prompt: prompt, formatter: formatter)
    end

    def nothing
      prompt.say 'Alright!'
    end

    def ensure_configuration
      if BitsDealer::Config.needs_configuration?
        prompt.error("\nIMPORTANT!!!\nBitsDealer is not configured, to start using it type 'configure'\n")
      else
        prompt.warn("Hey, we found some configuration files")
        password = prompt.mask("Please input your password to load them: ")
        @config = Config.new(password)
        prompt.ok("Configuration loaded.\n")
      end
    end
  end
end

