module Kms
  class TemplateProcessor
    def initialize(template)
      @template = template
    end

    def process
      template_document = Nokogiri::HTML @template.content
      template_document.search('script, link[rel="stylesheet"]').each do |tag|
        url = tag['src'] || tag['href']
        next unless url
        tag.replace "{{ '#{File.basename(url)}' | asset_tag }}"
      end
      # can't use Nokogiri for images because of Nokogiri escaping
      template_document.search('img').each do |tag|
        tag.replace %Q(<img src="{{ '#{File.basename(tag['src'])}' | asset_path }}" alt="#{tag['alt']}">)
      end
      template_document.to_html.gsub(/(%7B|%7D|%20|%7C)/,'%7B' => '{', '%7D' => '}', '%20' => ' ', '%7C' => '|')
    end
  end
end
