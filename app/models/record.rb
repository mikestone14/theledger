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

  def self.by_win_average
    order("(records.win_count::float / (records.win_count + records.loss_count)) desc")
  end

  def win_average
    (win_count.to_f / games_played).round(3)
  end

  def net_in_dollars
    (net_in_cents.to_f / 100).round(2)
  end

  def games_played
    win_count + loss_count
  end
end
