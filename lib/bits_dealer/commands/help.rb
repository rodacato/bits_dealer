module BitsDealer
  module Help
    def help
      choose do |menu|
        menu.prompt = "<%= color('>', BOLD) %> What do you want to do?  "
        menu.choice(:balance) { balance }
        menu.choices(:configure) { configure }
      end
    end
  end
end
