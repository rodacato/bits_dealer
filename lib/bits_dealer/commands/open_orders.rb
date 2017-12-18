module BitsDealer
  module OpenOrders
    def open_orders
      orders = with_retries(:max_tries => 3) { Bitsor.open_orders(limit: 100) }

      binding.pry

      table = Terminal::Table.new(
        :headings => [:book, :side, :amount, :price, :currency_price, :unfilled],
        :rows => orders.map do |order|
          side_formatted = order[:side] == 'buy' ? formatter.green(order[:side]) : formatter.red(order[:side])
          [order[:book], side_formatted, order[:original_amount], order[:original_value], order[:price], order[:unfilled_amount], ]
        end
      )

      prompt.say table

      nil
    end
  end
end
