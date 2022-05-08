Rails.application.routes.draw do
  root "tweets#index"

  resources :tweets
  resources :users
  resources :likes, only: %i[create]
  
  #customs routes
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  get "/profile", to: "users#edit"
  patch "/profile", to: "users#update"
  post "/profile", to: "users#create"

   # Omniauth
   get "/auth/github/callback", to: "sessions#create"

  #routes to API tests
  namespace :api do
    resources :tweets, except: %i[new edit]
    resources :users, except: %i[new edit]
  end
end
