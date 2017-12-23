module BitsDealer
  module CancelOrder
    def cancel_order(oid: nil)
      unless oid
        book = helper.ask_book(books: BitsDealer::Books::ALL_BOOKS)
        orders = with_retries(:max_tries => 3) { Bitsor.open_orders(book: book.id, limit: 100) }
        order = helper.ask_order(orders: orders)
        oid = order[:oid]
      end

      cancelled_order = with_retries(:max_tries => 3) { Bitsor.cancel_order(oid: oid) }
      prompt.ok "Order ##{cancelled_order.first} cancelled."

      nil
    end
  end
end

