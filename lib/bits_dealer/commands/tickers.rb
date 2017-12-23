require 'parallel'
require 'retries'

module BitsDealer
  module Tickers
    def tickers
      books = BitsDealer::Books::ALL_BOOKS
      tickers = Parallel.map(books) do |book|
        with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
      end

      helper.print_tickers_table(tickers: tickers)

      nil
    end
  end
end

