Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :lists, only: %i[ new create destroy ]
  resources :favorites, only: [:index]
  get '/public-lists', to: 'lists#public_lists'
  put '/favorite', to: 'favorites#favorite'
  delete 'delete-favorited-list', to: 'favorites#delete_favorited_list'
end
