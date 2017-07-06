Rails.application.routes.draw do
  root to: 'home#main'

  resources :sessions, only: [:new, :create, :destroy]
end
