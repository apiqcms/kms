require 'spec_helper'

describe Kms::UsersController, type: :controller do
  context 'when user/content manager' do
    login_user
    describe 'GET index' do
      it 'raises AccessDenied exception' do
        expect { get :index, format: :json }.to raise_error(CanCan::AccessDenied)
      end
    end
    describe 'GET kms_user' do
      it 'returns current user json representation' do
        get :kms_user, format: :json
        expect(response).to be_success
        expect(json.keys).to include('id', 'email', 'role', 'localized_role')
      end
    end
  end

  context 'when admin' do
    login_admin
    describe 'GET index' do
      it 'returns users json representation' do
        get :index, format: :json

        expect(response).to be_success
        expect(json.length).to eq(1)
        expect(json[0].keys).to include('id', 'email', 'role', 'localized_role')
      end
    end
    describe 'GET show' do
      it 'returns user json representation' do
        user = Kms::User.first
        get :show, params: { id: user.id }, format: :json
        expect(response).to be_success
        expect(json.keys).to include('id', 'email', 'role', 'localized_role')
      end
    end
    describe 'POST create' do
      context 'when save failed' do
        it "returns errors" do
          post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when save successful' do
        let(:user_params) { FactoryGirl.attributes_for(:user) }
        it "returns 204 status" do
          post :create, params: { user: user_params }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end
    describe 'PUT update' do
      let(:user) { FactoryGirl.create(:user) }
      context 'when update failed' do
        it 'returns errors' do
          put :update, params: { user: { password: 'password1', password_confirmation: 'password' }, id: user.id }, format: :json
          expect(json['errors']).to_not be nil
        end
      end
      context 'when update successful' do
        it "returns 204 status" do
          put :update, params: { user: { password: 'password1', password_confirmation: 'password1' }, id: user.id }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end
    describe 'DELETE user' do
      it 'deletes user and returns no content' do
        user = FactoryGirl.create(:user)
        delete :destroy, params: { id: user.id }, format: :json
        expect(response).to have_http_status(204)
      end
    end
  end

end
