require 'spec_helper'

describe Kms::Public::PagesController, type: :controller do

  describe 'GET show' do
    context 'when page was found' do

    end

    context 'when page not found' do
      context 'when special 404 page exists' do
        it 'returns 404 page content' do
          page_404 = FactoryGirl.create(:page_404)
          get :show, params: { path: 'blabla' }
          expect(response.status).to eq(404)
          expect(response.body).to include('Not Found')
        end
      end
      context 'when no special 404 page' do
        it 'returns 404.html from public folder' do
          get :show, params: { path: '/blabla' }
          expect(response.status).to eq(404)
          expect(response.body).to eq(File.read(File.join(Rails.root, 'public/404.html')))
        end
      end

    end
  end

end
