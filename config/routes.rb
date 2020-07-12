Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "landing#index"

  namespace :app do
    resource :dashboard
    resources :income_sources
  end
end
