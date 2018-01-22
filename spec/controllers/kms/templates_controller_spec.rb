require 'spec_helper'

describe Kms::TemplatesController, type: :controller do
  context 'when user/content manager' do
    login_user

    describe 'GET index' do
      it 'returns templates json representation' do
        FactoryGirl.create(:template)
        get :index, format: :json

        expect(response).to be_success
        expect(json.length).to eq(1)
      end
    end

  end

  context 'when admin' do
    let(:template) { FactoryGirl.create(:template) }

    login_admin

    describe 'POST create' do
      context 'when save failed' do
        it "returns errors" do
          post :create, params: { template: FactoryGirl.attributes_for(:invalid_template) }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when save successful' do
        let(:template_params) { FactoryGirl.attributes_for(:template) }
        it "returns 204 status" do
          post :create, params: { template: template_params }, format: :json
          expect(response).to have_http_status(204)
        end
        it "substitutes <script> and <link> tags with asset_tag helper in template content" do
          post :create, params: { template: template_params }, format: :json
          template = Kms::Template.find_by(name: template_params[:name])
          expect(template.content).to include("{{ 'compressed.js' | asset_tag }}")
          expect(template.content).to include("{{ 'fonts.css' | asset_tag }}")
        end
        it "substitutes <img src..> with <img src='{{ ... | asset_path }}' helper in template content" do
          post :create, params: { template: template_params }, format: :json
          template = Kms::Template.find_by(name: template_params[:name])
          expect(template.content).to include("{{ 'slide.jpg' | asset_path }}")
        end
      end
    end

    describe 'PUT update' do
      context 'when update failed' do
        it "returns errors" do
          put :update, params: { id: template.id, template: { name: nil } }, format: :json
          expect(response.unprocessable?).to be true
          expect(json['errors']).to_not be nil
        end
      end
      context 'when update successful' do
        let(:template_params) { FactoryGirl.attributes_for(:template) }
        it "returns 204 status" do
          put :update, params: { id: template.id, template: template_params }, format: :json
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'DELETE destroy' do
      it "deletes template" do
        delete :destroy, params: { id: template.id }, format: :json
        expect(response).to have_http_status(204)
      end
    end
  end

end
