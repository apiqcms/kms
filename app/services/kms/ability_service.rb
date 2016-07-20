module Kms
  class AbilityService
    cattr_accessor :abilities do
      []
    end

    def self.register(&block)
      self.abilities << block
    end
  end
end
