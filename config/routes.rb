Rails.application.routes.draw do

  resources :batches, except: [:edit, :update, :delete]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  get "/donate", to: "places#index"

  resources :donations, only: [:new, :create] do
  end

  get "/places/active", to: "places#active"

  root to: "home#welcome"
end
