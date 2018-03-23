require 'spec_helper'

module Kms
  describe Kms::Asset, type: :model do
    context 'when file uploaded in not UTF-8 encoding' do
      let(:asset) { FactoryGirl.build(:invalid_encoding_css_asset) }
      it 'should be invalid' do
        expect(asset).to_not be_valid
      end
    end

  end
end
