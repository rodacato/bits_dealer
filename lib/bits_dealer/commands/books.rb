require 'ostruct'

module BitsDealer
  module Books
    ALL_BOOKS = [
      OpenStruct.new({ id: "btc_mxn", name: :bitcoin, place_order: true, exchange_order: false, base_price_difference: 0.01 }),
      OpenStruct.new({ id: "eth_mxn", name: :etherium, place_order: true, exchange_order: false, base_price_difference: 0.01 }),
      OpenStruct.new({ id: "eth_btc", name: :etherium_bitcoin, place_order: false, exchange_order: true, base_price_difference: 0.00000001 }),
      OpenStruct.new({ id: "xrp_mxn", name: :ripple, place_order: true, exchange_order: false, base_price_difference: 0.01 }),
      OpenStruct.new({ id: "xrp_btc", name: :ripple_bitcoin, place_order: false, exchange_order: true, base_price_difference: 0.00000001 }),
    ]

    PLACE_ORDER_BOOKS = ALL_BOOKS.select(&:place_order)
    EXCHANGE_ORDER_BOOKS = ALL_BOOKS.select(&:exchange_order)

    def books
      table = Terminal::Table.new(
        :headings => [:name, :book],
        :rows => ALL_BOOKS.map{|book| [book.name, book.id] }
      )

      prompt.say table

      nil
    end
  end
end


