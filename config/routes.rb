Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"

  get "/dashboard" => "dashboard#show"

  resources :games, only: [:new, :create]
end
