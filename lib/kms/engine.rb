require "kms/dependencies"
require "kms/search_item"
require 'kms/drops/page_drop'
require 'kms/drops/search_item_drop'
require 'kms/functions/assets'
require 'kms/functions/currency'
require 'kms/externals/bigdecimal'
require 'kms/externals/request'
module Kms
  class Engine < ::Rails::Engine
    isolate_namespace Kms

    config.to_prepare do
      ::Devise::SessionsController.layout "kms/devise"
      ::Devise::RegistrationsController.layout "kms/devise"
      ::Devise::PasswordsController.layout "kms/devise"
      Dir.glob(Rails.root + "kms_*/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "kms.assets" do |app|
      app.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
      app.config.assets.precompile += %w(kms/application.js kms/application.css)
      app.config.assets.precompile += %w( avatar.jpg )
      app.config.assets.precompile += %w( **/*.svg **/*.eot **/*.woff **/*.ttf )
      app.config.assets.precompile += %w( ng-ckeditor/libs/ckeditor/** )
    end

    initializer "kms.compile_templates" do |app|
      app.config.before_initialize do
        Kms.template_manager = Liquor::Manager.new(import: Kms::FunctionsRegistry.modules)

        if ActiveRecord::Base.connection.tables.include?('kms_templates')
          Template.all.each do |template|
            Kms.template_manager.register_layout(template.register_id, template.content || "", Kms::ExternalsRegistry.externals.keys)
          end
        end
        if ActiveRecord::Base.connection.tables.include?('kms_pages')
          Page.all.each do |page|
            Kms.template_manager.register_template(page.register_id, page.content || "", Kms::ExternalsRegistry.externals.keys)
          end
        end
        if ActiveRecord::Base.connection.tables.include?('kms_snippets')
          Snippet.all.each do |snippet|
            Kms.template_manager.register_partial(snippet.register_id, snippet.content || "")
          end
        end

        unless Kms.template_manager.compile
          Kms.template_manager.errors.each do |error|
            puts error
          end
        end
      end
    end
  end
end
