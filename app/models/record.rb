class Record < ApplicationRecord
  belongs_to :leaderboard
  belongs_to :user

  validates :win_count, presence: true
  validates :loss_count, presence: true
  validates :net_in_cents, presence: true
end
