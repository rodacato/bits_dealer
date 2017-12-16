require 'yaml'
require 'fileutils'

module BitsDealer
  class Config
    def initialize(password)
      load_configurations(password)
      connect_to_bitso
    end

    def self.create(options)
      ensure_config_folder
      create_secrets_file(options)
      new(options[:password])
    end

    def self.reset
      FileUtils.remove_dir("#{Dir.home}/.bits_dealer")
    end

    def self.needs_configuration?
      !File.exist?("#{Dir.home}/.bits_dealer/secrets.yml")
    end

    private

    attr_reader :credentials

    def connect_to_bitso
      Bitsor.configure do |c|
        c.client_id = credentials[:client_id]
        c.api_key = credentials[:api_key]
        c.api_secret = credentials[:api_secret]
      end
    end

    def load_configurations(password)
      if File.exist?("#{Dir.home}/.bits_dealer/secrets.yml")
        secrets = YAML.load_file("#{Dir.home}/.bits_dealer/secrets.yml")

        @credentials = {
          client_id: secrets[:client_id].decrypt(password),
          api_key: secrets[:api_key].decrypt(password),
          api_secret: secrets[:api_secret].decrypt(password),
        }
      end
    end

    def self.create_secrets_file(values)
      File.open("#{Dir.home}/.bits_dealer/secrets.yml", "w") do |file|
          file.write(
            {
              client_id: values[:client_id].encrypt(values[:password]),
              api_key: values[:api_key].encrypt(values[:password]),
              api_secret: values[:api_secret].encrypt(values[:password]),
            }.to_yaml
          )
      end
    end

    def self.ensure_config_folder
      unless File.directory?("#{Dir.home}/.bits_dealer")
        FileUtils.mkdir_p("#{Dir.home}/.bits_dealer")
      end
    end
  end
end
