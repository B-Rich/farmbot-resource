require_relative 'abstract_resource'

module FbResource
  class Plants < AbstractResource
    self.path = '/api/plants/'
  end
end
