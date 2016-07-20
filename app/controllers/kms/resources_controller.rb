module Kms
  class ResourcesController < ApplicationController
    authorize_resource :class => false

    def index
      render json: ResourceService.external_resources_hash.to_json
    end
  end
end
