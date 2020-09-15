class LeaderboardsController < ApplicationController
  before_action :authorize

  def index
    @season = season
    @leaderboards = @season.leaderboards.order(created_at: :desc)
  end

  def show
    @leaderboard = Leaderboard.find(params[:id])
    @records = @leaderboard.records.by_score_and_win_average
  end

  def create
    if current_user.admin?
      LeaderboardService.run
    end

    redirect_to season_leaderboards_path(Season.active_season)
  end

  private

  def season
    if params[:season_id]
      Season.find(params[:season_id])
    else
      Season.active_season
    end
  end
end
