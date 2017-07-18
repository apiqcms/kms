require 'spec_helper'

module Kms
  describe Kms::Page, type: :model do
    it "should be registered via ResourceService" do
      expect(Kms::ResourceService.resources[:content_management][Kms::Page]).to_not be_nil
    end

    describe '#not_found?' do
      it 'returns if page has 404 slug or not' do
        page_404 = FactoryGirl.create(:page_404)
        expect(page_404.not_found?).to be true
      end
    end

    describe '.not_found_page' do
      context 'when 404 page exists' do
        it 'returns 404 page' do
          page_404 = FactoryGirl.create(:page_404)
          expect(Kms::Page.not_found_page).to be_eql(page_404)
        end
      end
      context 'when no 404 page' do
        it 'returns nil' do
          expect(Kms::Page.not_found_page).to be_nil
        end
      end
    end

  end
end
