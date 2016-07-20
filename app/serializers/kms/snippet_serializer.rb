module Kms
  class SnippetSerializer < ActiveModel::Serializer
    attributes :id, :name, :slug, :content
  end
end
