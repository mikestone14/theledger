class LeaderboardsController < ApplicationController
  before_action :authorize

  def index
    @season = Season.active_season
    @leaderboards = @season.leaderboards
  end

  def show
    @leaderboard = Leaderboard.find(params[:id])
    @records = @leaderboard.records.by_win_average
  end
end
