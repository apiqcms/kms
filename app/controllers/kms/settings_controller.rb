module Kms
  class SettingsController < ApplicationController
    authorize_resource :class => false

    def show
      render json: Settings.instance
    end

    def update
      @settings = Settings.instance
      if @settings.update(settings_params)
        render json: @settings
      else
        render json: @settings.to_json(methods: :errors), status: :unprocessable_entity
      end
    end

    protected

    def settings_params
      params.require(:setting).permit!
    end
  end
end
