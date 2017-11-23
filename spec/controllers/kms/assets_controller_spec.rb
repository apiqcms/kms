require 'spec_helper'

describe Kms::AssetsController, type: :controller do
  login_user
  describe 'GET index' do
    it 'returns assets json representation' do
      FactoryGirl.create(:asset)
      get :index, format: :json

      expect(response).to be_success
      expect(json.length).to eq(1)
    end
  end

  describe 'POST create' do
    context 'when creation successful' do
      it 'returns 200 status and creates asset' do
        asset_params = FactoryGirl.attributes_for(:asset)
        post :create, params: { asset: asset_params }, format: :json
        expect(response).to be_success
        expect(Kms::Asset.count).to eq(1)
      end
    end
    context 'when creation failed' do
      it 'returns errors' do
        css_asset = FactoryGirl.create(:css_asset)
        asset_params = FactoryGirl.attributes_for(:css_asset)
        post :create, params: { asset: asset_params }, format: :json
        expect(json['errors']).to_not be nil
      end
    end
  end

  describe 'PUT update' do
    # context 'when update failed' do
    #   it 'returns errors' do
          # put :update, params: { id: css_asset.id, asset: {performing_plain_text: true, text: 'h1 {}'} }, format: :json
    #     expect(json['errors']).to_not be nil
    #   end
    # end
    context 'when update successful' do
      it 'returns 200 status and updates asset' do
        css_asset = FactoryGirl.create(:css_asset)
        put :update, params: { id: css_asset.id, asset: {performing_plain_text: true, text: 'h1 {}'} }, format: :json
        expect(response).to be_success
        expect(Kms::Asset.find(css_asset.id).text).to be_eql('h1 {}')
      end
    end
  end

  describe 'GET show' do
    it 'returns asset json representation' do
      css_asset = FactoryGirl.create(:css_asset)
      get :index, params: { id: css_asset.id }, format: :json

      expect(response).to be_success
      expect(json[0]['text']).to eq(css_asset.text)
    end
  end

  describe 'DELETE destroy' do
    it "deletes asset" do
      asset = FactoryGirl.create(:asset)
      delete :destroy, params: { id: asset.id }, format: :json
      expect(response).to have_http_status(204)
      expect { Kms::Asset.find(asset.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
