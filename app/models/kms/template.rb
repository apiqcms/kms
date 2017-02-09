module Kms
  class Template < ActiveRecord::Base
    include CompileTemplates

    validates :name, presence: true

  end
end
