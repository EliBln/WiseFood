Rails.application.routes.draw do
  get 'recipes/show'
  get 'recipes/index'
  get 'recipes/create'
  get 'recipes/new'
  get 'user_recipes/create'
  get 'user_recipes/new'
  get 'user_recipes/index'
  get 'user_recipes/destroy'
  get 'products/new'
  get 'products/show'
  get 'products/index'
  get 'products/create'
  get 'products/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
