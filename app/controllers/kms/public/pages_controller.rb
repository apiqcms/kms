module Kms
  class Public::PagesController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :eval_externals

    def show
      page_result = Kms.template_manager.render(@page.register_id, @externals)
      result = Kms.template_manager.render(@template.register_id,
        @externals.merge(_inner_template: page_result))

      render html: result.html_safe, status: (@page.not_found? ? :not_found : :ok)
    end

    protected

    def eval_externals
      @externals = Hash[ExternalsRegistry.externals.map{ |k, v| [k, v.call(request, self)] }]
      @page = @externals[:page].source
      @template = @page.template
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end

  end
end
