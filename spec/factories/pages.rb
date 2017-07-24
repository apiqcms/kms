FactoryGirl.define do
  factory :invalid_page, class: Kms::Page do
    content <<-HTML
      <h1>About</h1>
    HTML
    published true
    template
    slug nil
    factory :index_page, class: Kms::Page do
      title 'Index'
      slug 'index'
    end
    factory :page, class: Kms::Page do
      sequence(:title){|n| "About#{n}" }
      sequence(:slug){|n| "about#{n}" }
      association :parent, factory: :index_page
    end
    factory :page_404, class: Kms::Page do
      slug '404'
      content <<-HTML
        <h1>Not Found</h1>
      HTML
      association :parent, factory: :index_page
    end
    factory :templatable_page, class: Kms::Page do
      slug 'template'
      templatable true
      templatable_type Kms::Snippet.name
      association :parent, factory: :index_page
    end
  end

end
