## :muscle: KMS is (K)Candidate Master of Sports :muscle:

KMS is a modern and flexible Ruby on Rails content management system with modular approach. It utilizes the most latest features from Rails and PostgreSQL (such as json column type, for example). Mostly inspired by LocomotiveCMS, but in contrast with it KMS relies on robust PostgreSQL database and doesn't provide all-in-one solution. The basic idea behind KMS: minimal core, extendable via extensions (engines). So you can take only what you need.

We, at [@webgradus](http://webgradus.com), used this CMS for our clients needs over past 1 year and now it's ready to be open sourced.
So feel free to use it in your projects.

## Built with good tools
* Ruby on Rails (4.1+). Not ready yet for Rails 5
* Angular.js
* Responsive Dashboard template
* Liquor template language
* PostgreSQL (recommended for DB)

## Features included:
- [x] Minimal **basis/core** - Templates, Pages, Assets and Snippets
- [x] Extendable via Rails Engines
- [x] Beautiful and responsive admin panel
- [x] Simple and Powerful Template language - [Liquor](https://github.com/evilmartians/liquor)
- [x] Built-in documentation/help

![Screenshot](http://webgradus.com/images/KMS.jpg)

## Installation

1. Add to Gemfile

        gem "kms", github: "webgradus/kms"

2. Setup database.yml (only PostgreSQL 9.2+ supported)

3. Run generator:

        rails g kms:install

4. Copy migrations:

        rake kms:install:migrations

5. Migrate:

        rake db:migrate

6. Set locale in your main app.

7. Precompile assets (if it will be production app):

        RAILS_ENV=production bundle exec rake assets:precompile

8. Run it using your favorite webserver - unicorn, puma, thin
9. Open your browser at **http://localhost:3000/kms** and sign up first admin user.

## Getting started
Please watch this video to start working in KMS:

[![Getting started in KMS - Ruby on Rails CMS](http://img.youtube.com/vi/WPZoWyd-thE/0.jpg)](https://youtu.be/WPZoWyd-thE "Getting started in KMS - Ruby on Rails CMS")

## Running problems

* Make sure you have "pids" and "sockets" folders in project's "tmp" folder (if using Puma especially)
* Won't work with Sprockets 3 (https://github.com/pitr/angular-rails-templates/issues/93). Solution: "gem 'sprockets', '2.12.4'"
