class Game < ApplicationRecord
  belongs_to :season
  belongs_to :winner, class_name: :User, foreign_key: :winner_id
  belongs_to :loser, class_name: :User, foreign_key: :loser_id

  validates :season, presence: true
  validates :winner, presence: true
  validates :loser, presence: true
  validates :price_in_cents, presence: true
end