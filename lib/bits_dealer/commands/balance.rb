module BitsDealer
  module Balance
    def balance(filter: nil)
      balance = Bitsor.balance
      helper.print_account_balance(balance: balance, filter: filter)
      nil
    end
  end
end

