require 'rubygems'
require 'bundler/setup'
require 'byebug'

require 'combustion'

Combustion.initialize! :all

require 'rspec/rails'
require 'factory_girl_rails'
require 'devise'
# require 'airborne'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include Requests::JsonHelpers, type: :controller
  config.color = true
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
end
# Airborne.configure do |config|
#   config.base_url = 'http://localhost:3000/kms'
# end
