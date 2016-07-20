require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret '<%= generate_secret %>'

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/uploads/dragonfly', Rails.env),
    server_root: Rails.root.join('public')

  fetch_url_whitelist /.+/

  processor :add_watermark do |content, watermark, dissolve, position|
    content.shell_update do |old_path, new_path|
      "composite -dissolve #{dissolve} -gravity #{position} #{watermark} #{old_path} #{new_path}"
    end
  end

end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
