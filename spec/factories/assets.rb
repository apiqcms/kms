FactoryGirl.define do
  factory :asset, class: Kms::Asset do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'avatar.jpg'), 'image/jpg') }
  end
  factory :css_asset, class: Kms::Asset do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'style.css'), 'text/stylesheet') }
  end
  factory :invalid_encoding_css_asset, class: Kms::Asset do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'invalid_encoding.css'), 'text/stylesheet') }
  end
end
