require_relative 'abstract_resource'

module FbResource
  class Device < AbstractResource
    self.path = '/api/device/'

    # Alias for #all() because #all() makes no sense on a singular resource. 
    def current
      all
    end
  end
end
