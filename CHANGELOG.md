## Version 1.0.0 Unreleased

* [changed] remove bunch of dependencies - less-rails, bower-rails and therubyracer
* [changed] updated gems dependencies
* [changed] updated Rails dependency (supporting Rails 5.1)
* [changed] update angular-ui-select
* [fixed] fix pages drag'n'drop issue allowing any other page to look like root page
* [fixed] Fix incorrect layout when model name is too long
* [added] some good looking blank slate screens
* [added] Show snippet slug/identifier in snippets table
* [changed] remove KMS mentions, a bit of translations additions + logo
* [added] Smart template creation
* [added] better specs coverage
* [added] ability to add custom 404 page as regular page with 404 slug
* [changed] use Casper font for text in CodeMirror
* [added] add TransliterationService and auto slug generation on page title typing

## Version 0.9.0 2017-05-25

* [changed] extract set_position method to concern - used in kms as well as in some extensions
* [added] add FunctionsRegistry service - for extending with Liquor functions
* [changed] remove special edit button for pages, make page title clickable
* [changed] make navigating to edit templates, snippets and assets simpler - just by clicking on names
* [added] add ability to setup Amazon S3 for assets storage
* [fixed] fix pages ordering issue - remove unnecessary request to pages - closes #14
* [added] add more help - about scopes/collection methods
* [changed] Angular 1.4 to 1.5 migration + angular-ui-tree update

## Version 0.8.0 2017-03-01

* [changed] update angular (angular-cookies, angular-sanitize) from 1.3 to 1.4
* [fixed] fix translations - remove &nbsp; + fix setting page parent_id on frontend
* [fixed] put settings form in each tab pane for correct display
* [fixed] more Rails 5 friendly (removing deprecation messages) + add views for password reset

## Version 0.7.0 2016-12-29

* [fixed] set default value for Kms::Settings values field + some translations
* [fixed] set correct carrierwave dependency
* [changed] new UI for Assets managing - split into tabs
* [added] add "save and continue" button for Snippets

## Version 0.6.0 2016-11-18

* [changed] Rails 5 support

## Version 0.5.0 2016-09-12

* [changed] updated angular-rails-templates gem and now Kms works with Sprockets 3 (Rails 4.2+)
* [changed] better page titles in admin section - issue #5

## Version 0.4.2 2016-09-12

* [fixed] fix issue when installing from Rubygems - vendor folder not included in gem package

## Version 0.4.1 2016-08-21

* [fixed] show CodeMirror editor even if Asset content type - 'text/x-csrc' or any text content type
* [added] matching tags in CodeMirror editor for pages, templates and snippets

## Version 0.4.0 2016-08-05

* [changed] use new font - Casper
* [changed] increase CodeMirror editor height
* [added] add "save and continue" buttons for templates and assets
* [added] add English translations
* [added] add Settings model and service - extensions can use it too for specifying settings

## Version 0.3.0 2016-02-09

* [fixed] code cleanup - remove redundant self
* [fixed] add textacular dependency since it's used for search
* [changed] add angular-i18n support for correct work of `date` filter
* [added] Add deleting users feature
* [added] add Fullscreen mode editing feature for CodeMirror textareas
* [added] `add_watermark` liquor function
* [added] add string `ends_with` liquor function
* [added] RSpec for testing
* [added] Snippets - small parts that could be reused - with `{% include 'snippet-id' %}`
* [added] introduce Angular ErrorsService for alerting about errors (more verbose output about Liquor errors)
* [added] introduce HelpService for registering help templates (could be used in extension to provide help about them)

## Version 0.2.0 2015-10-16

* [fixed] split validation step and compilation step - fixes bug when page not compiled
* [fixed] add base tag since this is a requirement of angular 1.3
* [fixed] Correct README, locale should be set before precompiling assets
* [fixed] prevent CKEditor from converting " to &quot;
* [changed] specify angular route for model entries explicitly
* [changed] update Angular to 1.3.3 + add ng-sortable dependency for sortable lists
* [added] render 404 page when not found
