require_relative 'abstract_resource'

module FbResource
  class Schedules < AbstractResource
    self.path = '/api/schedules/'
  end
end
