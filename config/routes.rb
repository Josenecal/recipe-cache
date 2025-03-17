Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "dashboard#index"

  # Create more intuitive login and logout routes

  get "/logout" => "sessions#destroy"
  get "/login" => "sessions#index"

  resource :session, only: [:create, :destroy]
  resolve('Session') { [:session]}

  resource :user, except: [:new] do # New User form embedded in new session view
    resources :recipes, only: [:index, :create, :destroy], controller: :user_recipes
  end
  resolve('User') { [:user] }

  resources :recipes 
    # resources :steps, only: [:create, :update, :destroy]
    # resources :ingredients, only: [:create, :update, :destroy]
    

  resources :friends
end
