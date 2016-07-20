module Kms
  class AssetsController < ApplicationController
    load_and_authorize_resource
    skip_before_action :verify_authenticity_token, only: :ckeditor

    def index
      render json: Asset.all.to_json(methods: [:filename, :url])
    end

    def create
      @asset = Asset.new(asset_params)
      if @asset.save
        render json: {success: true, files: [@asset]}.to_json
      else
        render text: '', status: :unprocessable_entity
      end
    end

    def ckeditor
      @asset = Asset.new(file: params[:upload])
      if @asset.save
        render text: %Q"<script type='text/javascript'>
            window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{@asset.file.url}');
          </script>"
      else
        render text: %Q"<script type='text/javascript'>
                window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, null, '#{@asset.errors.full_messages.first}');
              </script>"
      end
    end

    def update
      @asset = Asset.find(params[:id])
      asset_params.merge!(text: params[:text], performing_plain_text: params[:performing_plain_text]) if params[:text]
      @asset.update_attributes(asset_params)
      render json: @asset.to_json
    end

    def show
      @asset = Asset.find(params[:id])
      attrs = {}
      attrs.merge!(methods: [:text, :performing_plain_text]) if @asset.stylesheet_or_javascript?
      render json: @asset.to_json(attrs)
    end

    def destroy
      @asset = Asset.find(params[:id])
      @asset.destroy
      render json: @asset.to_json
    end

    protected

    def asset_params
      params.require(:asset).permit!
    end
  end
end