## Kms

![Screenshot](http://webgradus.com/images/KMS.jpg)

## Installation

1. Add to Gemfile

        gem "kms", git: "git@gitlab.com:webgradus/kms.git"

2. Setup database.yml

3. Run generator:

        rails g kms:install

4. Copy migrations:

        rake kms:install:migrations

5. Migrate:

        rake db:migrate

6. Set locale in your main app.

7. Precompile assets:

        RAILS_ENV=production bundle exec rake assets:precompile

8. Setup unicorn.rb or puma.rb and add foreman support with:

        babushka webgradus:'foreman.start'

## Running problems

* Make sure you have "pids" and "sockets" folders in project's "tmp" folder (if using Puma especially)
* Won't work with Sprockets 3 (https://github.com/pitr/angular-rails-templates/issues/93). Solution: "gem 'sprockets', '2.12.4'"
* If Init script doesn't work correctly, check it cause it was made by foreman export for Rails project with Capistrano support - replace "shared" in APPPIDDIR


This project rocks and uses MIT-LICENSE.
