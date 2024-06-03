Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"

  resources :users, only: %i[new create show edit update destoroy]
  resources :posts, only: %i[index show new create edit update destroy]
end
