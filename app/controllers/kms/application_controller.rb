module Kms
  class ApplicationController < ActionController::Base
    before_action :authenticate_kms_user!
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    after_action :set_csrf_cookie_for_ng

    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

    protected

    def verified_request?
      super || cookies['XSRF-TOKEN'] == request.headers['X-XSRF-TOKEN']
    end

    def current_ability
      @current_ability ||= Ability.new(current_kms_user)
    end
  end
end
