require 'spec_helper'

module Kms
  describe Kms::Asset, type: :model do
    context 'when file uploaded in not UTF-8 encoding' do
      let(:asset) { FactoryGirl.create(:invalid_encoding_css_asset) }
      it 'will be converted into utf-8' do
        cd = CharDet.detect(asset.text)
        expect(cd['encoding']).to eq 'utf-8'
      end
    end

  end
end
