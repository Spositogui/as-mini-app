Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :lists, only: %i[ new create destroy ]
end
