module Kms
  module Positioned
    extend ActiveSupport::Concern

    included do
      before_create :set_position
    end

    def set_position
      if parent.present?
        max = parent.children.maximum(:position)
      else
        max = self.class.where('ancestry IS ?', nil).maximum(:position)
      end
      self.position = max ? max + 1 : 0
    end
  end
end
