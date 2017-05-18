module Kms
  class PagesController < ApplicationController
    load_and_authorize_resource
    wrap_parameters :page, include: [:title, :slug, :content, :published, :template_id, :templatable,:templatable_type,:position,:hidden, :parent_id]

    def index
      #render json: Page.order("created_at asc").to_json(methods: :parent_id, except: :ancestry)
      render json: Page.arrange_serializable(order: :position).to_json
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        render json: @page.to_json
      else
        render json: @page.to_json(except: :ancestry, methods: :errors), status: :unprocessable_entity
      end
    end

    def update
      @page = Page.find(params[:id])
      if @page.update_attributes(page_params)
        render json: @page.to_json
      else
        render json: @page.to_json(except: :ancestry, methods: :errors), status: :unprocessable_entity
      end
    end

    def show
      @page = Page.find(params[:id])
      render json: @page.to_json(methods: :parent_id, except: :ancestry)
    end

    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      render json: @page.to_json
    end

    def sorting
      params["_json"].each_with_index do |page, index|
        p = Page.find_by_id(page["id"])
        p.update_attribute(:parent_id, nil)
        p.update_attribute(:position, index)
        sort(page["id"], page["children"]) if page["children"].present?
      end
      render json: Page.arrange_serializable(order: :position).to_json
    end

    protected

    def sort(id, pages)
      pages.each_with_index do |page, index|
       p = Page.find_by_id(page["id"])
       p.update_attribute(:parent_id, id)
       p.update_attribute(:position, index)
       if page["children"].present?
         sort(page["id"], page["children"])
       end
      end
    end

    def page_params
      params.require(:page).permit!
    end
  end
end
