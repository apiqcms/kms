require 'spec_helper'

describe Kms::PagesController, type: :controller do
    login_user

    describe 'GET index' do
      it 'returns pages json representation' do
        FactoryGirl.create(:page)
        get :index, format: :json

        expect(response).to be_success
        expect(json.length).to eq(1)
      end
    end

    describe 'POST create' do
      context 'when save failed' do
        it "returns errors" do
          post :create, params: { page: FactoryGirl.attributes_for(:invalid_page) }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when save successful' do
        let(:page_params) { FactoryGirl.attributes_for(:page) }
        it "returns 204 status" do
          post :create, params: { page: page_params }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'PUT update' do
      let(:page) { FactoryGirl.create(:page) }
      context 'when update failed' do
        it "returns errors" do
          put :update, params: { id: page.id, page: FactoryGirl.attributes_for(:invalid_page) }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when update successful' do
        let(:page_params) { FactoryGirl.attributes_for(:page) }
        it "returns 204 status" do
          put :update, params: { id: page.id, page: page_params }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'GET show' do
      let(:page) { FactoryGirl.create(:page) }
      it "returns page json representation" do
        get :show, params: { id: page.id }, format: :json
        expect(response).to be_success
        expect(json['title']).to eq(page.title)
      end
    end

    describe 'DELETE destroy' do
      let(:page) { FactoryGirl.create(:page) }
      it "deletes page" do
        delete :destroy, params: { id: page.id }, format: :json
        expect(response).to have_http_status(204)
      end
    end

    describe 'POST sorting' do
      it "sorts pages according to updated order" do
        page1 = FactoryGirl.create(:page)
        page2 = FactoryGirl.create(:page, parent: Kms::Page.where(slug: 'index').first)
        pages_tree = Kms::Page.arrange_serializable(order: :position)
        # reorder here
        pages_tree[0]['children'].sort! {|a,b| b['position'] <=> a['position'] }
        post :sorting, params: { '_json' => [pages_tree]}, format: :json
        expect(response).to be_success
        expect(json[0]['children'][0]['slug']).to eq(page2.slug)
        expect(json[0]['children'][-1]['slug']).to eq(page1.slug)
      end
    end

end
