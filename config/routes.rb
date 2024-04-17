Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "session#index"

  get "/logout" => "session#destroy"

  get "/dashboard" => "dashboard#index"

  post "/user/create" => "user#create" 
  post "/user/login" => "user#login"

  get "/recipes/new" => "recipes#new"
  get "/recipes/:id" => "recipes#show"
  get "/recipes/:id/edit" => "recipes#edit"
  get "/recipes" => "recipes#index"
  post "/recipes/create" => "recipes#create"
  
  get "/friends" => "friends#index"
end
