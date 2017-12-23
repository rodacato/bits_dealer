module BitsDealer
  module Help
    def help
      option = prompt.select("Choose what you want to do?") do |menu|
        menu.choice 'Cancel order', 'cancel_order'
        menu.choice 'Check balances', 'balance'
        menu.choice 'List books', 'books'
        menu.choice 'List tickets', 'tickers'
        menu.choice 'New order', 'new_order'
        menu.choice 'Nevermind', 'nothing'
      end

      process(option)

      nil
    end
  end
end
