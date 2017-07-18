FactoryGirl.define do
  factory :invalid_template, class: Kms::Template do
    content <<-HTML
      <html>
        <head>
          <link rel="stylesheet" href="fonts.css">
        </head>
        <body>
          <img src="images/slide.jpg" alt="">
          {% yield %}
          <script src="compressed.js"></script>
        </body>
      </html>
    HTML
    factory :template, class: Kms::Template do
      name "Main"
    end
  end

end
