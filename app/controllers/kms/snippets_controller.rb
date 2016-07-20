module Kms
  class SnippetsController < ApplicationController
    respond_to :json

    def index
      respond_with Snippet.all, root: false
    end

    def create
      @snippet = Snippet.create(snippet_params)
      respond_with @snippet, root: false
    end

    def update
      @snippet = Snippet.find(params[:id])
      @snippet.update(snippet_params)
      respond_with @snippet, root: false
    end

    def show
      @snippet = Snippet.find(params[:id])
      respond_with @snippet, root: false
    end

    def destroy
      @snippet = Snippet.find(params[:id])
      @snippet.destroy
      respond_with @snippet
    end

    protected

    def snippet_params
      params.require(:snippet).permit!
    end
  end
end
