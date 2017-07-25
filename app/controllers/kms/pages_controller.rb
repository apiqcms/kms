module Kms
  class PagesController < ApplicationController
    load_and_authorize_resource
    wrap_parameters :page, include: [:title, :slug, :content, :published, :template_id, :templatable,:templatable_type,:position,:hidden, :parent_id]

    def index
      render json: Page.arrange_serializable(order: :position)
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        head :no_content
      else
        render json: {errors: @page.errors}.to_json, status: :unprocessable_entity
      end
    end

    def update
      @page = Page.find(params[:id])
      if @page.update(page_params)
        head :no_content
      else
        render json: {errors: @page.errors}.to_json, status: :unprocessable_entity
      end
    end

    def show
      @page = Page.find(params[:id])
      render json: @page
    end

    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      head :no_content
    end

    def sorting
      params["_json"].each_with_index do |page, index|
        p = Page.find_by_id(page["id"])
        p.update_attribute(:parent_id, nil)
        p.update_attribute(:position, index)
        sort(page["id"], page["children"]) if page["children"].present?
      end
      render json: Page.arrange_serializable(order: :position)
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
      params.require(:page).permit(:title, :slug, :content, :published, :hidden, :template_id, :parent_id, :position, :templatable, :templatable_type)
    end
  end
end
