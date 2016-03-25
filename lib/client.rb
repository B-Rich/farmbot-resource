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

    def self.get_token(url: "http://my.farmbot.io", email:, password:)
      # TODO handle auth errors in a more civilized manner.
      resource_url = url + "/api/tokens"
      payload = {user: {email: email, password: password}}
      result = RestClient.post(resource_url, payload)
      json = JSON.parse(result)
      token = json["token"]
      string = token["encoded"]
      string
    end

    # Useful when you need to sign arbitrary secrets and give them to the server
    def public_key
      if @public_key
        return @public_key
      else
        api_url = config.url + "api/public_key"
        pem = Http.get(api_url, {}).body
        @public_key = OpenSSL::PKey::RSA.new(pem)
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
      JSON.parse(Base64.decode64(config.token.split(".")[1]))["iss"]
    end

  private

    def invalidate(msg)
      raise InvalidConfig.new, msg
    end

    def post_config
      invalidate("config needs `token` attribute") unless @config.token
      @config.url = api_url
    end
  end
end
