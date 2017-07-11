module Kms
  class TemplateProcessor
    def initialize(template)
      @template = template
    end

    def process
      template_document = Nokogiri::HTML::DocumentFragment.parse @template.content
      template_document.search('script, link[rel="stylesheet"]').each do |tag|
        tag.replace("{% '#{File.basename(tag['src'] || tag['href'])}' | asset_tag %}")
      end
      template_document.to_html
    end
  end
end
