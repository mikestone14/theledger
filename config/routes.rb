Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#show"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"

  get "/dashboard" => "dashboard#show"

  resources :games, only: [:new, :create]
  resources :leaderboards, only: [:show, :create]

  resources :seasons, only: [:index] do
    resources :leaderboards, only: [:index, :show]
    resources :games, only: [:index]
  end
end
