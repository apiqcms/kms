module Kms
  class Template < ActiveRecord::Base
    include CompileTemplates

    validates :name, presence: true

    def register_id
      "#{self.class.name.parameterize("_")}_#{id}"
    end
  end
end
