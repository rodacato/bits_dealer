module BitsDealer
  module OpenOrders
    def open_orders
      book = helper.ask_book
      orders = with_retries(:max_tries => 3) { Bitsor.open_orders(book: book.id, limit: 100) }

      table = Terminal::Table.new(
        :headings => [:book, :oid, :side, :amount, :total_price, :unit_price, :unfilled],
        :rows => orders.map do |order|
          side_formatted = order[:side] == 'buy' ? formatter.green(order[:side]) : formatter.red(order[:side])
          [order[:book], order[:oid], side_formatted, order[:original_amount], order[:original_value], order[:price], order[:unfilled_amount], ]
        end
      )

      prompt.say table

      nil
    end
  end
end

