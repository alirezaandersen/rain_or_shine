Rails.application.routes.draw do

root 'users#index'

resources :weathers, only: [:new, :create, :show]

resources :facebooks, only: [:index]
get '/facebooks/update_timeline/:city', to: 'facebooks#update_timeline', as: :update_timeline

get '/auth/facebook', as: :facebook_login
get '/auth/facebook/callback', to: 'sessions#create'
get "/logout", to: "sessions#destroy"

end
