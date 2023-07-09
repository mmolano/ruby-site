# frozen_string_literal: true

Rails.application.routes.draw do
  get '/password', to: 'passwords#edit', as: 'password_edit'
  patch '/password', to: 'passwords#update'

  get '/password/reset', to: 'password_reset#new'
  post '/password/reset', to: 'password_reset#create'
  get '/password/reset/edit', to: 'password_reset#edit'
  patch '/password/reset/edit', to: 'password_reset#update'

  get '/about', to: 'about#index'

  get '/signup', to: 'user#new'
  post '/signup', to: 'user#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  root to: 'main#index'

  resources :users
end
