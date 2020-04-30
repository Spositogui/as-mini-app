Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :lists, only: %i[ new edit create update destroy ]
  resources :favorites, only: [:index]
  get '/public-lists', to: 'lists#public_lists'
  get '/entire-list', to: 'lists#see_entire_list'
  put '/favorite', to: 'favorites#favorite'
  delete 'delete-favorited-list', to: 'favorites#delete_favorited_list'
end
