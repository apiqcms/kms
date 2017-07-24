module Kms
  class SearchItem
    extend ActionView::Helpers::TextHelper
    include Liquor::Dropable
    include Liquor::External

    attr_reader :title, :content, :link

    HIGHLIGHTER = '<mark class="highlight">\1</mark>'.freeze

    def initialize opts
      @title = opts[:title]
      @link = opts[:link]
      @content = opts[:content]
    end

    export :link
    export :title
    export :content

    def link
      @link
    end

    def title
      @title
    end

    def content
      @content
    end

    # attributes_map for Kms::Page is:
    # {title: :title, link: :fullpath, content: :content}
    def self.item_for_searchable(searchable, keywords, attributes_map)
      sanitized_title = ActionController::Base.helpers.sanitize(searchable[attributes_map[:title]])
      sanitized_content = ActionController::Base.helpers.sanitize(searchable[attributes_map[:content]])
      Kms::SearchItem.new(
        title: highlight(sanitized_title, keywords, highlighter: HIGHLIGHTER, sanitize: false),
        link: searchable[attributes_map[:link]],
        content: highlight(sanitized_content, keywords, highlighter: HIGHLIGHTER, sanitize: false)
      )
    end

  end
end
