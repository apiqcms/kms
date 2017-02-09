module Kms
  class Public::PagesController < ActionController::Base

    before_action :eval_externals

    def show
      page_result = Kms.template_manager.render(@page.register_id, @externals)
      # apply typograph to page content
      #page_result = EvilFront::Russian.typograph_html(page_result)
      result   = Kms.template_manager.render(@template.register_id, @externals.
                              merge(_inner_template: page_result))

      render plain: result, content_type: "text/html"
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
