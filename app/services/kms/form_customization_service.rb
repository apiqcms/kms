module Kms
  class FormCustomizationService
    cattr_accessor :resources do
      Hash.new {|h, key| h[key] = []}
    end

    # resource - resource class
    # fields - additional templates for resource form
    def self.register_templates(resource, *templates)
      resources[resource].concat templates
    end

  end
end
