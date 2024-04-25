Rails.application.routes.draw do

  root 'welcome#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/home', to: 'welcome#index'

  resources :users


end
