class Record < ApplicationRecord
  belongs_to :leaderboard
  belongs_to :user

  validates :win_count, presence: true
  validates :loss_count, presence: true
  validates :net_in_cents, presence: true

  MIN_GAME_COUNT = 25

  def self.eligible
    where("win_count + loss_count >= ?", MIN_GAME_COUNT)
  end

  def self.ineligible
    where("win_count + loss_count < ?", MIN_GAME_COUNT)
  end

  def self.create_for_user_and_leaderboard(user, leaderboard)
    season = leaderboard.season
    games_won = Game.active.where(season: season, winner: user)
    games_lost = Game.active.where(season: season, loser: user)
    net_in_cents = games_won.sum(:price_in_cents) - games_lost.sum(:price_in_cents)
    win_count = games_won.count
    loss_count = games_lost.count
    score = CalculateRecordScore.call(
      win_count: win_count,
      loss_count: loss_count,
      net_in_cents: net_in_cents,
    )

    create!(
      leaderboard: leaderboard,
      user: user,
      win_count: win_count,
      loss_count: loss_count,
      net_in_cents: net_in_cents,
      score: score,
    )
  end

  def self.by_score_and_win_average
    order(Arel.sql("score DESC, (records.win_count::float / ((case when records.win_count = 0 then 1 else records.win_count end) + records.loss_count)) desc"))
  end

  def win_average
    return 0 if games_played.zero?

    (win_count.to_f / games_played).round(3)
  end

  def net_in_dollars
    (net_in_cents.to_f / 100).round(2)
  end

  def games_played
    win_count + loss_count
  end
end
