class DashboardController < ApplicationController
  before_action :authorize

  def show
    @users = User.all
    @season = Season.active_season
    @recent_games = @season
      .games
      .includes(:winner, :loser)
      .last(6)
  end
end
