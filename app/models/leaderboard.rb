class Leaderboard < ApplicationRecord
  belongs_to :season
  has_many :records, dependent: :destroy

  validates :name, presence: true
end
