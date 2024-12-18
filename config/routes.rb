Rails.application.routes.draw do
  get "recipes/show"
  get "recipes/index"
  get "recipes/create"
  get "recipes/new"
  get "products/loading"
  get "camera" => "products#camera"
  resources :products
  resources :user_recipes, only: [:index, :destroy, :create]
  devise_for :users
  resources :recipes, only: [:show]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/openai/create_recipe', to: 'openai#create_recipe'

  # Defines the root path route ("/")
  # root "posts#index"
end
