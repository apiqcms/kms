require 'spec_helper'

describe Kms::SnippetsController, type: :controller do
  context 'when user/content manager' do
    login_user

    describe 'GET index' do
      it 'raises AccessDenied exception' do
        FactoryGirl.create(:snippet)
        expect { get :index, format: :json }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  context 'when admin' do
    login_admin

    describe 'GET index' do
      it 'returns snippets json representation' do
        FactoryGirl.create(:snippet)
        get :index, format: :json

        expect(response).to be_success
        expect(json.length).to eq(1)
      end
    end

    describe 'POST create' do
      context 'when save failed' do
        it "returns errors" do
          post :create, params: { snippet: FactoryGirl.attributes_for(:invalid_snippet) }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when save successful' do
        it "returns 204 status" do
          snippet_params = FactoryGirl.attributes_for(:snippet)
          post :create, params: { snippet: snippet_params }, format: :json
          expect(response).to have_http_status(204)
        end
      end

    end

    describe 'PUT update' do
      context 'when update failed' do
        it "returns errors" do
          snippet = FactoryGirl.create(:snippet)
          put :update, params: { id: snippet.id, snippet: {slug: nil} }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when update successful' do
        it "returns 204 status" do
          snippet = FactoryGirl.create(:snippet)
          put :update, params: { id: snippet.id, snippet: {slug: 'new-slug'} }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'GET snippet' do
      it "returns snippet object" do
        snippet = FactoryGirl.create(:snippet)
        get :show, params: { id: snippet.id }, format: :json
        expect(response).to be_success
        expect(json['name']).to eq(snippet.name)
        expect(json['slug']).to eq(snippet.slug)
        expect(json['content']).to eq(snippet.content)
      end
    end

    describe 'DELETE snippet' do
      it 'deletes snippet and returns no content' do
        snippet = FactoryGirl.create(:snippet)
        delete :destroy, params: { id: snippet.id }, format: :json
        expect(response).to have_http_status(204)
      end
    end
  end
end
