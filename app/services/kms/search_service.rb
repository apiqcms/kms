module Kms
  class SearchService
    cattr_accessor :resources do
      {}
    end

    def initialize(query='')
      @query = query
    end

    # resource is a class
    # attributes_map is a Hash
    # where keys are SearchItem attributes like "title", "link" and "content"
    # and values are corresponding resource attributes
    def self.register(resource, attributes_map)
      self.resources[resource] = attributes_map
    end

    def search
      return [] if @query.blank?

      search_results = Kms::SearchService.resources.map do |resource, attributes_map|
        resource_items = resource.advanced_search(keywords.join('|'))
        resource_items.map {|resource_item| Kms::SearchItem.item_for_searchable(resource_item, keywords, attributes_map) }
      end
      search_results.flatten
    end

    private

    def keywords
      @query.split(' ')
    end

  end
end
