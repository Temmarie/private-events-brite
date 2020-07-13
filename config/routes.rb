Rails.application.routes.draw do
  root 'events#index'
  resources :users
  resources :events
  resources :sessions, only: [:new, :create, :destroy]
  resources :event_attendees, only: [:create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
