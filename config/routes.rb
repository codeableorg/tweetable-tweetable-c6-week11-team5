Rails.application.routes.draw do
  root "tweets#index"


  resources :tweets
  resources :users, only: %i[new create]

  #customs routes
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  get "/profile", to: "users#edit"
  patch "/profile", to: "users#update"
  post "/profile", to: "users#create"
end
