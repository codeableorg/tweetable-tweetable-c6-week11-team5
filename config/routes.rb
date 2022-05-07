Rails.application.routes.draw do
  resources :tweets
  resources :users
  resources :likes, only: %i[create]
  root "tweets#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
