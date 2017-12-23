module BitsDealer
  module NewOrder
    DEFAULT_ORDER_AMOUNT = 50.0

    def buy_order
      book = helper.ask_book
      minor = prompt.ask("How much MXN invest?", convert: :float, default: DEFAULT_ORDER_AMOUNT, help_color: :green)

      ticker = with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
      ticker_price = ticker[:bid] + book.base_price_difference
      helper.print_tickers_table(tickers: [ticker])
      price = prompt.ask("What price?", convert: :float, default: ticker_price, help_color: :green)

      begin
        order = place_order(book, :buy, minor, price)
        prompt.ok("Order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end

      nil
    end

    def sell_order
      book = helper.ask_book
      minor = prompt.ask("How much MXN collect?", convert: :float, default: DEFAULT_ORDER_AMOUNT, help_color: :green)

      ticker = with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
      ticker_price = ticker[:ask] - book.base_price_difference
      helper.print_tickers_table(tickers: [ticker])
      price = prompt.ask("What price?", convert: :float, default: ticker_price, help_color: :green)

      begin
        order = place_order(book, :sell, minor, price)
        prompt.ok("Order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end
    end

    private

    def place_order(book, side, minor, price)
      major = (minor/price).round(6)

      with_retries(:max_tries => 3) {
        Bitsor.place_order(book: book.id, side: side, type: :limit, major: major.to_s, price: price.to_s)
      }
    end
  end
end
