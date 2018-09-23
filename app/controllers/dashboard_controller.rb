class DashboardController < ApplicationController
  before_action :authorize

  def show
    @users = User.all
    @recent_games = Season.active_season
      .games
      .includes(:winner, :loser)
      .last(6)
  end
end
