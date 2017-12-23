module BitsDealer
  module Help
    def help
      option = prompt.select("Choose what you want to do?") do |menu|
        menu.enum '.'
        menu.choice 'Nevermind', 'nothing'

        menu.choice 'Cancel order', 'cancel_order'
        menu.choice 'Buy order', 'buy_order'
        menu.choice 'Sell order', 'sell_order'
        menu.choice 'Exchange order', 'exchange_order'
      end

      process(option)

      nil
    end
  end
end
