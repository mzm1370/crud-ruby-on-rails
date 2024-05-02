Rails.application.routes.draw do
  # get 'registrations/new'
  # get 'registrations/create'

  root 'welcome#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  # get '/register', to: 'users#new'
  # post '/register', to: 'users#create'

  get '/register', to: 'registrations#new'
  post '/register', to: 'registrations#create'

  get '/home', to: 'welcome#index'

  resources :users


end
