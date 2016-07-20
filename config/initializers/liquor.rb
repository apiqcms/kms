require 'kms/functions/assets'
require 'kms/functions/currency'
#Kms.template_manager = Liquor::Manager.new(import: [Liquor::Pagination, Kms::Functions::Assets, Kms::Functions::Currency])

# if ActiveRecord::Base.connection.tables.include?('kms_templates')
#   Kms::Template.all.each do |template|
#     Kms.template_manager.register_layout(template.register_id, template.content || "", Kms::ExternalsRegistry.externals.keys)
#   end
# end
# if ActiveRecord::Base.connection.tables.include?('kms_pages')
#   Kms::Page.all.each do |page|
#     Kms.template_manager.register_template(page.register_id, page.content || "", Kms::ExternalsRegistry.externals.keys)
#   end
# end
#Rails.configuration.x.template_manager.register_partial("_pagination", <<-eos
#{% pagination start: %}
#<div class='digg_pagination'>
  #{% if page.is_current then: %}
  #<span class="disabled previous_page">&#8592; Previous</span>
  #{% else: %}
  #<a href="{{ prev_page_path }}" rel="previous" class="previous_page_page">&#8592; Previous</a>
  #{% end if %}
#{% page: %}
  #{% if page.is_current then: %}
  #<em class="current">{{ page.number }}</em>
  #{% elsif: page.is_next then: %}
  #<a href="{{ page.path }}" rel="next">{{ page.number }}</a>
  #{% elsif: page.is_prev then: %}
  #<a href="{{ page.path }}" rel="previous">{{ page.number }}</a>
  #{% else: %}
  #<a href="{{ page.path }}">3</a>
  #{% end if %}
#{% gap: %}
  #<span class="gap">&hellip;</span>
#{% end: %}
  #{% if page.is_current then: %}
  #<span class="disabled next_page">Next &#8594;</span>
  #{% else: %}
  #<a href="{{ next_page_path }}" rel="next" class="next_page">Next &#8594;</a></div>
  #{% end if %}
#{% end pagination %}
#eos
                                                       #)

# unless Kms.template_manager.compile
#   Kms.template_manager.errors.each do |error|
#     puts error
#   end
# end
