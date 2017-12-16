module BitsDealer
  module Configure
    def configure
      if !BitsDealer::Config.needs_configuration?
        prompt.say "BitsDealer is already configured"
      end

      client_id = prompt.ask("What is your cliend id?")
      api_key = prompt.ask("What is your api key?")
      api_secret = prompt.ask("What is your api secret?")
      password = nil
      password_input = 0

      loop do
        password = prompt.mask("\nSet a password for your configuration: ")
        password_confirmation = prompt.mask("confirm your password: ")

        if password == password_confirmation
          break
        else
          password_input += 1
          prompt.error "Your password didnt match, please try it again"
        end

        if password_input == 3
          prompt.warn "Configuration failed, try again!!!"
          break
        end
      end

      @config = BitsDealer::Config.create({ client_id: client_id, api_key: api_key, api_secret: api_secret, password: password })

      prompt.ok 'You have configured BitsDealer.'

      nil
    end

    def reset
      confirm = prompt.yes?("Are you sure you want to delete your configuration?") do |q|
        q.default false
      end

      if confirm
        BitsDealer::Config.reset
        prompt.ok "Configuration removed."
      end

      nil
    end
  end
end
