Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#show"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"

  get "/dashboard" => "dashboard#show"

  resources :games, only: [:new, :create]
  get "/seasons/active/games", to: "games#index", as: :active_season_games
end
