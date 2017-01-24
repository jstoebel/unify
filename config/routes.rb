Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  get "/donate", to: "map#main"

  resources :donations, only: [:new, :create]

  get "/places/active", to: "places#active"
  root to: "home#welcome"
end
