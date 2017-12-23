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
        order = helper.place_order(book, :buy, minor, price)
        prompt.ok("Order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end

      nil
    end

    def sell_order
      book = helper.ask_book

      balance(filter: book.id.split('_'))
      minor = prompt.ask("How much MXN collect?", convert: :float, default: DEFAULT_ORDER_AMOUNT, help_color: :green)

      ticker = with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
      ticker_price = ticker[:ask] - book.base_price_difference
      helper.print_tickers_table(tickers: [ticker])
      price = prompt.ask("What price?", convert: :float, default: ticker_price, help_color: :green)

      begin
        order = helper.place_order(book, :sell, minor, price)
        prompt.ok("Order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end

      nil
    end

    def exchange_order
      book = helper.ask_book(books: BitsDealer::Books::EXCHANGE_ORDER_BOOKS)
      book_names = book.id.split('_')

      balance(filter: book_names)
      minor = prompt.ask("How much #{book_names.first} convert?", convert: :float)

      ticker = with_retries(:max_tries => 3) { Bitsor.ticker(book: book.id) }
      ticker_price = ticker[:ask] - book.base_price_difference
      helper.print_tickers_table(tickers: [ticker])
      price = prompt.ask("What price?", convert: :float, default: '%.8f' % ticker_price, help_color: :green)

      begin
        order = helper.exchange_order(book, minor, price)
        prompt.ok("Exchange order ##{order[:oid]} placed.")
      rescue => error
        prompt.error("Failed to place the order with: #{error.message}")
      end

      nil
    end
  end
end
