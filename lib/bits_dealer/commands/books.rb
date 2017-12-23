module BitsDealer
  module Books
    DEFAULT_BOOKS = {
      bitcoin: "btc_mxn",
      etherium: "eth_mxn",
      etherium_bitcoin: "eth_btc",
      ripple: "xrp_mxn",
      ripple_bitcoin: "xrp_btc",
    }

    def books
      table = Terminal::Table.new(
        :headings => [:name, :book],
        :rows => DEFAULT_BOOKS.map{|key, value| [key, value] }
      )

      prompt.say table

      nil
    end
  end
end


