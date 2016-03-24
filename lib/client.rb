require_relative 'config'

module FbResource
  class Client
    attr_reader :config

    def initialize(&blk)
      @config = Config.build
      yield(@config)
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

    def schedules
      @schedules ||= FbResource::Schedules.new(config)
    end

    def sequences
      @sequences ||= FbResource::Sequences.new(config)
    end

    def plants
      @plants ||= FbResource::Plants.new(config)
    end
  end
end
