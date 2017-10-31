Rails.application.routes.draw do
  namespace :kms do
    constraints(format: "json") do
      resources :pages, format: true do
        collection do
          post 'sorting'
        end
      end
      resources :templates, except: [:new, :edit], format: true
      resources :snippets, except: [:new, :edit], format: true
      resources :users, only: [:index, :destroy, :update, :show], format: true do
        post :from_kms, on: :collection, action: :create
        get :kms_user, on: :collection
      end
      resources :assets, except: [:new, :edit], format: true, as: :kms_assets
    end
  end
end
