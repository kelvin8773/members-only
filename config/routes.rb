Rails.application.routes.draw do
  root 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :users
  resources :posts, only: [:new, :create, :index]
end
