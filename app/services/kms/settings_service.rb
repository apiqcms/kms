module Kms
  class SettingsService
    cattr_accessor :templates do
      Hash.new {|h, key| h[key] = []}
    end

    # engine - engine class
    # settings_templates - engine settings templates
    def self.register_templates(engine, *settings_templates)
      templates[engine].concat settings_templates
    end
  end
end
