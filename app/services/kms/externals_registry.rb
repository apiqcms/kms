module Kms
  class ExternalsRegistry
    cattr_accessor :externals do
      {}
    end

    def self.register(external, &block)
      self.externals[external] = block
    end
  end
end
