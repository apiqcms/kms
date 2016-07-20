FactoryGirl.define do
  factory :invalid_snippet, class: Kms::Snippet do
    content "MyText"
    factory :snippet, class: Kms::Snippet do
      name "Snippet"
      slug "my-snippet"
    end
  end

end
