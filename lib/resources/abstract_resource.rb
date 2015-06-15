require_relative '../http/http'

module FbResource
  class FetchError < Exception; end
  class AbstractResource
    class << self
      attr_writer :path
      def path
        @path or
        raise "Set a resource path on your resource class via self.path="
      end
    end

    attr_accessor :conf

    def initialize(conf)
      @conf = conf
    end

    def fetch
        Http
          .get(conf.url + self.class.path, conf.creds)
          .no { |e| no(e) }
          .ok { |obj, req, res| fetch_ok(obj, req, res) }
    end

    def no(error)
      raise FetchError, "Error fetching #{self.class.to_s}: #{error.message}"
    end

    def fetch_ok(obj, request, response)
      @all = obj
    end

    def all
      @all || fetch
    end
  end
end
