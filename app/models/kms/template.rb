module Kms
  class Template < ActiveRecord::Base
    include CompileTemplates

    validates :name, presence: true

    def register_id
      (self.class.name << "_" << self.id.to_s).parameterize(separator: "_")
    end
  end
end
