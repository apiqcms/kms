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
  search_service = Kms::SearchService.new(request.params[:query])
  search_service.search
end
