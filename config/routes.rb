Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :lists, only: %i[ new create destroy ]
  get '/public-lists', to: 'lists#public_lists'
  put '/favorite', to: 'favorites#favorite'
end
