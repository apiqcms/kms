module Kms
  class SnippetsController < ApplicationController
    respond_to :json

    def index
      render json: Snippet.all, root: false
    end

    def create
      @snippet = Snippet.create(snippet_params)
      render json: @snippet, root: false
    end

    def update
      @snippet = Snippet.find(params[:id])
      @snippet.update(snippet_params)
      render json: @snippet, root: false
    end

    def show
      @snippet = Snippet.find(params[:id])
      render json: @snippet, root: false
    end

    def destroy
      @snippet = Snippet.find(params[:id])
      @snippet.destroy
      render json: @snippet
    end

    protected

    def snippet_params
      params.require(:snippet).permit!
    end
  end
end
