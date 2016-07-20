module Kms
  class HelpService
    cattr_accessor :templates do
      Hash.new {|h, key| h[key] = []}
    end

    # engine - engine class
    # help_templates - engine help templates
    def self.register_templates(engine, *help_templates)
      templates[engine].concat help_templates
    end
  end
end
