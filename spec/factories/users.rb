FactoryGirl.define do
  factory :invalid_user, class: Kms::User do
    sequence(:email){|n| "admin#{n}@example.com" }
    factory :user, class: Kms::User do
      password "password"
      password_confirmation "password"
      factory :admin do
        role 'admin'
      end
    end
  end
end
