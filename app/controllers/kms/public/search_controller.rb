module Kms
  class Public::SearchController < ActionController::Base
    protect_from_forgery with: :exception

    def search
      results = Page.advanced_search(params[:query]).to_drop#.split(' ').join('|').to_drop
      if params[:result_page] and @page = Page.find_by_fullpath(params[:result_page])
        @externals = Hash[ExternalsRegistry.externals.map{ |k, v| [k, v.call(request, self)] }]
        @template = @page.template

        page_result = Rails.configuration.x.template_manager.render(@page.register_id, @externals.merge!(search: results))
        result = Rails.configuration.x.template_manager.render(@template.register_id, @externals.merge(_inner_template: page_result))

        render text: result, layout: false
      else
        redirect_to root_path
      end
    end
  end
end
