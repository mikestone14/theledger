class Record < ApplicationRecord
  belongs_to :leaderboard
  belongs_to :user

  validates :win_count, presence: true
  validates :loss_count, presence: true
  validates :net_in_cents, presence: true

  def self.create_for_user_and_leaderboard(user, leaderboard)
    season = leaderboard.season
    games_won = Game.where(season: season, winner: user)
    games_lost = Game.where(season: season, loser: user)
    net_in_cents = games_won.sum(:price_in_cents) - games_lost.sum(:price_in_cents)

    create!(
      leaderboard: leaderboard,
      user: user,
      win_count: games_won.count,
      loss_count: games_lost.count,
      net_in_cents: net_in_cents,
    )
  end
end
