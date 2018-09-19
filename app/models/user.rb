class User < ApplicationRecord
  has_secure_password
  has_many :winning_games, class_name: :Game, foreign_key: :winner_id
  has_many :losing_games, class_name: :Game, foreign_key: :loser_id

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def active_season_game_count
    Game.
      where(season: Season.active_season).
      where("winner_id = :winner_id OR loser_id = :loser_id", winner_id: id, loser_id: id).
      count
  end
end
