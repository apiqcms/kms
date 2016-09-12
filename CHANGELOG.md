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
