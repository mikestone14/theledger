class DashboardController < ApplicationController
  before_action :authorize

  def show
    @recent_games = Season.active_season.games.includes(:winner, :loser).last(6)
  end
end
