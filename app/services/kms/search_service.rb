module Kms
  class SearchService
    cattr_accessor :resources do
      []
    end

    def self.register(resource)
      self.resources << resource
    end
  end
end
