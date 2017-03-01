module Kms
  module CompileTemplates
    extend ActiveSupport::Concern

    included do
      validate :compiled_templates
      # on validation step object has no id,
      # that's why we need additional compile if validation pass
      after_commit :compile_templates, on: [:create, :update]
    end

    def register_id
      [self.class.name.parameterize(separator: "_"), id.to_s].join('_')
    end

    protected

    def compiled_templates
      Kms.template_manager.diagnostics.clear
      register_liquor_template
      return if Kms.template_manager.compile
      Kms.template_manager.errors.each do |error|
        splitted_error = error.message.split(':')
        errors.add(:content, [Kms.template_manager.decorate(error), splitted_error].flatten.join('<br>').gsub(/\s/, '&nbsp;'))
      end
    end

    def register_liquor_template
      if is_a?(Kms::Template)
        Kms.template_manager.register_layout(register_id, content, Kms::ExternalsRegistry.externals.keys)
      elsif is_a?(Kms::Page)
        Kms.template_manager.register_template(register_id, content, Kms::ExternalsRegistry.externals.keys)
      elsif is_a?(Kms::Snippet)
        Kms.template_manager.register_partial(register_id, content)
      end
    end

    def compile_templates
      register_liquor_template
      Kms.template_manager.compile
    end
  end
end
