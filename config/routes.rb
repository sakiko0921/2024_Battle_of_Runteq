Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"

  resources :users, only: %i[new create edit update]
  resources :posts, only: %i[new create index show edit update destroy]
  resources :my_pages, only: %i[top create ]

  get "/about", to: "static_pages#about"

  get "/my_page", to: "my_pages#top"

  get "/login", to: "users_sessions#new"
  post "/login", to: "users_sessions#create"

  delete "/logout", to: "users_sessions#destroy"
end
