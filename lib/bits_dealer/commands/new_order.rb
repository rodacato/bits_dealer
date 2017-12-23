module BitsDealer
  module NewOrder
    DEFAULT_ORDER_AMOUNT = 50.0

    def new_order
      book_options = BitsDealer::Books::DEFAULT_BOOKS

      book = prompt.select("Choose the book?") do |menu|
        menu.enum '.'

        book_options.each_pair do |key, value|
          menu.choice key, value
        end
      end

      ticker = with_retries(:max_tries => 3) { Bitsor.ticker(book: book) }
      ticker_price = ticker[:bid] + 0.01

      minor = prompt.ask("How much MXN?", convert: :float, default: DEFAULT_ORDER_AMOUNT, help_color: :green)

      print_tickers_table([ticker])
      price = prompt.ask("What price?", convert: :float, default: ticker_price, help_color: :green)

      begin
        order = place_new_order(book, minor, price)
        prompt.ok("Order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end

      nil
    end

    private

    def place_new_order(book, minor, price)
      major = (minor/price).round(6)

      with_retries(:max_tries => 3) {
        Bitsor.place_order(book: book, side: :buy, type: :limit, major: major.to_s, price: price.to_s)
      }
    end
  end
end
