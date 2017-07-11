FactoryGirl.define do
  factory :template, class: Kms::Template do
    name "Main"
    content <<-HTML
      <html>
        <head>
          <link rel="stylesheet" href="fonts.css">
        </head>
        <body>
          <script src="compressed.js"></script>
        </body>
      </html>
    HTML
  end

end
