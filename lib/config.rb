require 'ostruct'

module FbResource
  class Config < OpenStruct
    def creds
      { BOT_UUID: self.uuid, BOT_TOKEN: self.token }
    end

    def self.build
      # Set defaults
      self
        .new
        .tap {|obj| obj.url = 'http://localhost:3000'}
    end
  end
end
