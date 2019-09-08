Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#show"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"

  get "/dashboard" => "dashboard#show"

  resources :games, only: [:new, :create]
  resources :leaderboards, only: [:show, :create]

  get "/seasons/active/games", to: "games#index", as: :active_season_games
  get "/seasons/active/leaderboards", to: "leaderboards#index", as: :active_season_leaderboards
end
