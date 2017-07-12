module Kms
  class TemplatesController < ApplicationController
    load_and_authorize_resource
    def index
      render json: Template.all
    end

    def create
      @template = Template.new(template_params)
      @template.content = TemplateProcessor.new(@template).process
      if @template.save
        head :no_content
      else
        render json: {errors: @template.errors}.to_json, status: :unprocessable_entity
      end
    end

    def update
      @template = Template.find(params[:id])
      if @template.update_attributes(template_params)
        render json: @template.to_json
      else
        render json: @template.to_json(methods: :errors), status: :unprocessable_entity
      end
    end

    def show
      @template = Template.find(params[:id])
      render json: @template.to_json
    end

    def destroy
      @template = Template.find(params[:id])
      @template.destroy
      render json: @template.to_json
    end

    protected

    def template_params
      params.require(:template).permit(:name,:content)
    end
  end
end
