require_relative 'config'
require 'base64'

module FbResource
  class InvalidConfig < StandardError; end
  class Client
    attr_reader :config

    def initialize(&blk)
      @config = Config.build
      yield(@config)
      post_config
    end

    def self.get_token(url: "http://my.farmbot.io",
                       email: "EMAIL NOT SET",
                       password: "PASSWORD NOT SET",
                       credentials: nil)
      # TODO handle auth errors in a more civilized manner.
      resource_url = url + "/api/tokens"
      if(credentials)
        result = from_credentials(resource_url, credentials)
      else
        result = from_email_and_password(resource_url, email, password)
      end
      parse_token(result)
    end

    # Useful when you need to sign arbitrary secrets and give them to the server
    def public_key
      @public_key ||= self.class.public_key(config.url)
    end

    def self.public_key(url = "my.farmbot.io")
      wow = Http.get(url + "/api/public_key", {})
      if wow.response.code.to_i < 400
        return OpenSSL::PKey::RSA.new(wow.body)
      else
        raise "Unable to fetch public key. Is the server down?"
      end
    end

    def device
      @device ||= FbResource::Device.new(config)
    end

    def schedules
      @schedules ||= FbResource::Schedules.new(config)
    end

    def sequences
      @sequences ||= FbResource::Sequences.new(config)
    end

    def plants
      @plants ||= FbResource::Plants.new(config)
    end

    def api_url
      raw = config.token.split(".")[1] + "=="
      token_string = Base64.decode64(raw)
      hash = JSON.parse(token_string)
      hash["iss"]
    rescue JSON::ParserError
      msg = "Farmbot Resource couldn't parse the auth token provided:\n\n"
      msg += token_string + "\n\n"
      raise InvalidConfig, msg
    end

  private

    def invalidate(msg)
      raise InvalidConfig.new, msg
    end

    def post_config
      invalidate("config needs `token` attribute") unless @config.token
      @config.url = api_url
    end

    def self.from_credentials(resource_url, credentials)
      payload = {user: {credentials: credentials}}
      RestClient.post(resource_url, payload)
    end

    def self.from_email_and_password(resource_url, email, password)
      payload = {user: {email: email, password: password}}
      RestClient.post(resource_url, payload)
    end

    def self.parse_token(result)
      json = JSON.parse(result)
      token = json["token"]
      string = token["encoded"]
      string
    end
  end
end
