include ActionView::Helpers::TextHelper
Kms::ExternalsRegistry.register(:request) {|request, controller| Liquor::Rails::Request.new(request, controller) }
Kms::ExternalsRegistry.register(:index) {|_,_| Kms::Page.find_by_slug!("index").to_drop }
Kms::ExternalsRegistry.register(:page) do |request,_|
    page_fetcher = Kms::PageFetcher.new(request.params[:path] || Kms::Page::INDEX_FULLPATH)
    page_fetcher.fetch!
end
Kms::ExternalsRegistry.register(:item) do |request,controller|
  page = Kms::ExternalsRegistry.externals[:page].call(request, controller)
  if page && page.source.templatable?
    page.source.fetch_item(File.basename(request.params[:path])).try(:to_drop)
  end
end
Kms::ExternalsRegistry.register(:search) do |request,_|
    results = []
    if request.params[:query].present?
        key_words = request.params[:query].split(' ')
        results_ids = Kms::Page.published.advanced_search(key_words.join('|')).map(&:id)
        results = Kms::Page.published.where('id IN (?)', results_ids).map {|page| Kms::SearchItem.new(title: highlight(page.title, key_words, highlighter: '<span class="highlight">\1</span>'), link: page.fullpath, content: highlight(page.content, key_words, highlighter: '<span class="highlight">\1</span>'))}

        Kms::SearchService.resources.each do |resource|
            resource_ids = resource.advanced_search(request.params[:query].split(' ').join('|')).map(&:id)
            resource_items = resource.where('id IN (?)', resource_ids)
            parent_page = Kms::Page.published.find_by_templatable_type(resource)
            resource_items.each do |item|
                results << Kms::SearchItem.new(title: highlight(item.title, key_words, highlighter: '<span class="highlight">\1</span>'), link: parent_page.parent.fullpath + '/' + item.slug, content: highlight(item.content, key_words, highlighter: '<span class="highlight">\1</span>'))
            end if parent_page && parent_page.templatable
        end
    end

    results
end
