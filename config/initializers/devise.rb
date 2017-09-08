module Kms
  module Devise

    class FailureApp < ::Devise::FailureApp

      include ::Kms::Engine.routes.url_helpers

      def redirect_url
        new_kms_user_session_path
      end

      # You need to override respond to eliminate recall
      def respond
        if http_auth?
          http_auth
        else
          redirect
        end
      end

    end

  end
end
