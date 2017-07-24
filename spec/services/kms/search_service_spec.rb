require 'spec_helper'

describe Kms::SearchService, type: :service do
  describe '.register' do
    it "should register searchable resources" do
      Kms::SearchService.register(Kms::Snippet, {title: :name, link: :slug, content: :content})
      expect(Kms::SearchService.resources[Kms::Snippet]).to eq({title: :name, link: :slug, content: :content})
    end
    after do
      Kms::SearchService.resources = {}
    end
  end
  describe '#search' do
    context 'when no searchable resources registered' do
      it 'returns empty array' do
        page = Kms::Page.create(title: 'Home', slug: 'index', content: 'Home page', published: true)
        search_service = Kms::SearchService.new('Home')
        result = search_service.search
        expect(search_service.search).to be_empty
      end
    end
    context 'when searchable resource registered' do
      before do
        Kms::SearchService.register(Kms::Page, {title: :title, link: :fullpath, content: :content})
      end
      context 'when no query passed' do
        it 'returns empty array' do
          search_service = Kms::SearchService.new("")
          expect(search_service.search).to be_empty
        end
      end
      context 'when query present' do
        context 'when a searchable resource has searched term' do
          it 'returns array with SearchItem object' do
            page = Kms::Page.create(title: 'Home', slug: 'index', content: 'Home page', published: true)
            search_service = Kms::SearchService.new('Home')
            result = search_service.search
            expect(result[0]).to be_instance_of(Kms::SearchItem)
          end
        end
        context 'when no searchable resource having such term' do
          it 'returns empty array' do
            page = Kms::Page.create(title: 'Home', slug: 'index', content: 'Home page', published: true)
            search_service = Kms::SearchService.new('Super')
            expect(search_service.search).to be_empty
          end
        end
      end
    end


  end
end
