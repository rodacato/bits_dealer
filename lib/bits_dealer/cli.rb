require 'bitsor'

module BitsDealer
  class CLI
    attr_accessor :options

    def initialize(args)
      self.options = parse_options(args)
    end

    def run
      BitsDealer::REPL.new(options).start
    end

    private

    # @private
    def parse_options(args)
      {}.tap do |options|

        OptionParser.new do |opts|
          opts.banner = "Usage: bits_dealer [options]"

          opts.on('--reset', 'Remove your configuration files') do
            options[:reset] = true
          end

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end
        end.parse!(args)

      end
    end
  end
end

