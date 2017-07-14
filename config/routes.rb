Rails.application.routes.draw do
  root to: 'home#main'

  resources :sessions, only: [:new, :create]
  delete :session, to: 'sessions#destroy'
  resources :users, only: [:new, :create]
end
