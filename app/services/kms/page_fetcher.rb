module Kms
  class PageFetcher
    def initialize(path)
      @path = path
    end

    def fetch!
      page = Page.published.find_by_fullpath(@path) || fetch_templatable_page! || fetch_404_page
      page ? page.to_drop : raise(ActiveRecord::RecordNotFound)
    end

    private

    # finds templatable page that works for path
    def fetch_templatable_page!
      parent_page_path = File.dirname(@path)
      parent_page_path = Kms::Page::INDEX_FULLPATH if parent_page_path == "."
      parent_page = Kms::Page.published.find_by_fullpath!(parent_page_path)
      templatable_pages = parent_page.children.where(templatable: true)
      templatable_pages.detect do |templatable_page|
        templatable_page.fetch_item(File.basename(@path))
      end
    end

    # find special page with '404' slug
    def fetch_404_page
      Kms::Page.not_found_page
    end
  end
end
