module Kms
  class ResourceService
    cattr_accessor :resources do
      {}
    end

    NON_TEMPLATABLE_CLASSES = [Page, Template, Asset, User, Snippet].freeze

    def self.register(group, resource, tab_icon_class)
      self.resources[group] ||= {}
      self.resources[group][resource] = tab_icon_class
    end

    def self.unregister(group, resource)
      self.resources[group].delete(resource)
    end

    def self.external_resources_hash
      self.resources.values.map(&:keys).flatten.reject {|r| NON_TEMPLATABLE_CLASSES.include?(r)}.map do |resource_class|
        {type: resource_class.name, title: resource_class.model_name.human}
      end
    end
  end
end
