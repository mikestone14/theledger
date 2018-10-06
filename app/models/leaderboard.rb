class Leaderboard < ApplicationRecord
  belongs_to :season

  validates :name, presence: true
end
