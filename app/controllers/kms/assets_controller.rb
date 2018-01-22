module Kms
  class AssetsController < ApplicationController
    load_and_authorize_resource
    skip_before_action :verify_authenticity_token, only: :ckeditor
    wrap_parameters :asset, include: [:file, :text, :performing_plain_text]

    def index
      render json: Asset.all
    end

    def create
      @asset = Asset.new(asset_params)
      if @asset.save
        # special json for ng-flow
        render json: { success: true, files: [@asset] }.to_json
      else
        render json: { errors: @asset.errors.full_messages }.to_json, status: :unprocessable_entity
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
      if @asset.update(asset_params)
        render json: @asset
      else
        render json: { errors: @asset.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    def show
      @asset = Asset.find(params[:id])
      render json: @asset
    end

    def destroy
      @asset = Asset.find(params[:id])
      @asset.destroy
      head :no_content
    end

    protected

    def asset_params
      params.require(:asset).permit(:file, :text, :performing_plain_text)
    end
  end
end
