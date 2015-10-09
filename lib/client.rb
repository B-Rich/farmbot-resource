require_relative 'config'

module FbResource
  class Client
    attr_reader :config

    def initialize(&blk)
      @config = Config.build
      yield(@config)
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
