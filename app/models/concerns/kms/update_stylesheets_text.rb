module Kms
  module UpdateStylesheetsText
    extend ActiveSupport::Concern

    included do
      after_commit :restore_text, on: :create
    end

    protected

    def restore_text
      unless stylesheet_or_javascript?
        Asset.where("content_type like '%css%'").each do |asset|
          asset.store_text
          asset.save
        end
      end
    end
  end
end
