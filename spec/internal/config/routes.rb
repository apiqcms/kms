Rails.application.routes.draw do
  namespace :kms do
    constraints(format: "json") do
      resources :templates, format: true
      resources :snippets, format: true
    end
  end
end
