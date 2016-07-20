module Kms
  class SearchItem
    include Liquor::Dropable
    include Liquor::External
    attr_reader :title, :content, :link
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
  end
end
