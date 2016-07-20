module Kms
  module Devise

    class FailureApp < ::Devise::FailureApp

      include ::Kms::Engine.routes.url_helpers

      def redirect_url
        new_kms_user_session_path
      end

    end

  end
end
