Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  get "/donate", to: "map#main"
  post "/donate", to: "map#checkout"
  root to: "home#welcome"
end
