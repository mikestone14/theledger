class User < ApplicationRecord
  has_secure_password
  has_many :winning_games,
    class_name: :Game,
    foreign_key: :winner_id,
    dependent: :destroy,
    inverse_of: :winner
  has_many :losing_games,
    class_name: :Game,
    foreign_key: :loser_id,
    dependent: :destroy,
    inverse_of: :loser

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  enum status: { active: 0, inactive: 1 }

  def active_season_game_count
    Game
      .where(season: Season.active_season)
      .where("winner_id = :winner_id OR loser_id = :loser_id", winner_id: id, loser_id: id)
      .count
  end

  def game_count
    Game.current_season.where("winner_id = ? OR loser_id = ?", id, id).count
  end
end
