require 'ostruct'

module FbResource
  class Config < OpenStruct
    def http_headers
      { Authorization: self.token }
    end

    def self.build
      # Set defaults
      self
        .new
        .tap {|obj| obj.url = 'http://localhost:3000'}
    end
  end
end
