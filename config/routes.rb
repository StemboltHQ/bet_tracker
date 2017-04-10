Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create', as: :sessions
  delete '/logout', to: 'sessions#destroy', as: :session

  get '/signup', to: 'users#new', as: :new_user_path

  get 'bets/:id/resolve', to: 'bets#resolve', as: :resolve_bet

  resources :bets do
    resources :user_bets, only: :create
    resources :bet_options, shallow: true
  end
  resources :users
end
