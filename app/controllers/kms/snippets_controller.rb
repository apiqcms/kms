module Kms
  class SnippetsController < ApplicationController
    load_and_authorize_resource
    respond_to :json

    def index
      render json: Snippet.all, root: false
    end

    def create
      @snippet = Snippet.new(snippet_params)
      if @snippet.save
        head :no_content
      else
        render json: { errors: @snippet.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    def update
      @snippet = Snippet.find(params[:id])
      if @snippet.update(snippet_params)
        head :no_content
      else
        render json: { errors: @snippet.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    def show
      @snippet = Snippet.find(params[:id])
      render json: @snippet, root: false
    end

    def destroy
      @snippet = Snippet.find(params[:id])
      @snippet.destroy
      head :no_content
    end

    protected

    def snippet_params
      params.require(:snippet).permit(:name, :slug, :content)
    end
  end
end
