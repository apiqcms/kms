module Kms
  class TemplateSerializer < ActiveModel::Serializer
    attributes :id, :name, :content
  end
end
