module Kms
  class AssetSerializer < ActiveModel::Serializer
    attributes :id, :content_type, :filename, :url
    attribute :text, if: -> { object.stylesheet_or_javascript? }
  end
end
