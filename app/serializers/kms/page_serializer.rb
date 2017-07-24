module Kms
  class PageSerializer < ActiveModel::Serializer
    attributes :id, :title, :slug, :template_id, :parent_id, :content, :published, :hidden, :templatable, :templatable_type
  end
end
