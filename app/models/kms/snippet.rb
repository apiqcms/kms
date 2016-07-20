module Kms
  class Snippet < ActiveRecord::Base
    include CompileTemplates

    validates :name, :slug, presence: true

    def register_id
      ['_', slug].join
    end
  end
end
