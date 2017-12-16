module BitsDealer
  module Configure
    def configure
      if !BitsDealer::Config.needs_configuration?
        display "BitsDealer is already configured", :green
      end

      client_id = Readline.readline("What is your cliend id?\n> ", true)
      api_key = Readline.readline("What is your api key?\n> ", true)
      api_secret = Readline.readline("What is your api secret?\n> ", true)
      password = nil
      password_input = 0

      loop do
        password = Readline.readline("\nSet a password when start BitsDealer:\n> ", true)
        password_confirmation = Readline.readline("\nconfirm your password:\n> ", true)

        if password == password_confirmation
          break
        else
          password_input += 1
          display "Your password didnt match, please try it again", :red
        end

        if password_input == 3
          display "Configuration failed, try again!!!", :red
          break
        end
      end

      @config = BitsDealer::Config.create({ client_id: client_id, api_key: api_key, api_secret: api_secret, password: password })

      display 'You have configured BitsDealer.', :green
    end

    def reset
      confirm = Readline.readline("Are you sure you want to delete your configuration files?[Yn]\n> ", true)

      if confirm.downcase == 'y' || confirm.downcase == 'yes'
        BitsDealer::Config.reset
        display "Configuration removed.", :green
      end
    end
  end
end
