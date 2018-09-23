class GamesController < ApplicationController
  before_action :authorize

  def new
    @game = Game.new
    @users = User.all
  end

  def create
    @game = Game.new(create_game_params)

    if @game.save
      redirect_to dashboard_path, notice: "Game recorded."
    else
      @users = User.all

      flash.now[:alert] = @game.errors.full_messages.join(", ")
      render :new
    end
  end

  def index
    @season = Season.active_season
    @games = @season
      .games
      .includes(:winner, :loser)
  end

  private

  def create_game_params
    game_params
      .except(:price)
      .merge(
        price_in_cents: price_in_cents,
        season: Season.active_season,
      )
  end

  def game_params
    params.require(:game).permit(:winner_id, :loser_id, :price)
  end

  def price_in_cents
    price = game_params.fetch(:price)
    return if price.blank?

    (price.to_f * 100).to_i
  end
end
