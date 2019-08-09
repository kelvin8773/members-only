Rails.application.routes.draw do
  root 'posts#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  resources :users, only: [:show]
  resources :posts, only: [:new, :create, :index]
end
