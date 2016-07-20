FactoryGirl.define do
  factory :user, class: Kms::User do
    email "admin@example.com"
    password "password"
    password_confirmation "password"
  end
end
