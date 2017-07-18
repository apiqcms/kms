require 'spec_helper'

describe Kms::PageFetcher, type: :service do
  describe '#fetch' do
    let(:request) {
      request = ActionController::TestRequest.new({host:  'example.com', params: {path: '/about'}, request_uri: '/about', 'rack.input' => StringIO.new}, ActionController::TestRequest.new_session)
      request.tap {|r| r.path_parameters = {path: 'about' } }
    }
    subject { Kms::PageFetcher.new(request) }
    context 'when there"s a page with exact fullpath' do
      it "returns current page drop by given path" do
        page = FactoryGirl.create(:page)
        result_page = subject.fetch!
        expect(result_page).to be_instance_of(Kms::PageDrop)
        expect(result_page.source).to be_eql(page)
      end
    end
    context 'when there"s a templatable page responding to path' do
      it "returns templatable page for this path" do
        snippet = FactoryGirl.create(:snippet, slug: 'about')
        templatable_page = FactoryGirl.create(:templatable_page)
        result_page = subject.fetch!
        expect(result_page.source.templatable).to be true
      end
    end
    context 'when no page for path but 404 page exists' do
      it "returns 404 page" do
        page_404 = FactoryGirl.create(:page_404)
        result_page = subject.fetch!
        expect(result_page.slug).to be_eql('404')
      end
    end
    context 'when no page and no special 404 page' do
      it 'raises RecordNotFound exception' do
        expect {subject.fetch!}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
