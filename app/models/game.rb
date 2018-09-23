class Game < ApplicationRecord
  belongs_to :season
  belongs_to :winner, class_name: :User, foreign_key: :winner_id, inverse_of: :winning_games
  belongs_to :loser, class_name: :User, foreign_key: :loser_id, inverse_of: :losing_games

  validates :season, presence: true
  validates :winner, presence: true
  validates :loser, presence: true
  validates :price_in_cents, presence: true

  scope :current_season, -> { where(season: Season.active_season) }

  def price_in_dollars
    (price_in_cents.to_f / 100).round(2)
  end
end
