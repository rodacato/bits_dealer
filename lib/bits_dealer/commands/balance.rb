module BitsDealer
  module Balance
    def balance
      balance = Bitsor.balance
      table = Terminal::Table.new(
        :headings => [:currency, :available, :locked, :total, :pending_deposit, :pending_withdrawal],
        :rows => balance[:balances].map{|currency| currency.values }
      )

      prompt.say table

      nil
    end
  end
end

