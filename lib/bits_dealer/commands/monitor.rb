require 'parallel'
require 'retries'
require 'ostruct'

module BitsDealer
  module Monitor
    def start_monitors
      @monitor_data = OpenStruct.new({
        tickers: [],
        stats: {}
      })

      _monit_tickers
      _process_stats
    end

    private

    attr_reader :monitor

    def monitor_tickers
      Thread.kill(@tickers_thread) if @tickers_thread
      Thread.abort_on_exception = true
      @tickers_thread = Thread.new do
        loop do
          books = BitsDealer::Books::ALL_BOOKS
          tickers = Parallel.map(books) do |book|
            with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
          end
          @monitor_data.tickers = [{ created_at: Time.now.to_i, data: tickers }] + @monitor_data.tickers[0..19]
          sleep 20
        end
      end
    end

    def process_stats

    end

  end
end
