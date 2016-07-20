Rails.application.routes.draw do
  namespace :kms do
    constraints(format: "json") do
      resources :snippets, format: true
    end
  end
end
