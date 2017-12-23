require 'parallel'
require 'retries'

module BitsDealer
  module Tickers
    def tickers
      books = BitsDealer::Books::DEFAULT_BOOKS.values
      tickers = Parallel.map(books) do |book|
        with_retries(:max_tries => 3) { Bitsor.ticker(book: book) }
      end

      helper.print_tickers_table(tickers)

      nil
    end
  end
end

