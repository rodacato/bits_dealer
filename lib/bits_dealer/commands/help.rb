module BitsDealer
  module Help
    def help
      option = prompt.select("Choose what you want to do?") do |menu|
        menu.choice 'Check balances', 'balance'
        menu.choice 'Nevermind', 'nothing'
      end

      process(option)

      nil
    end
  end
end
