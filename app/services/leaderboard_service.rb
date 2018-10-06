class LeaderboardService
  TIME_ZONE = "America/New_York".freeze
  TIME_FORMAT = "%m/%d/%y @ %I:%M%p EST".freeze

  def self.run(name: nil, season:)
    new(name, season).run
  end

  def initialize(name, season)
    @name = name
    @season = season
  end

  def run
    create_leaderboard
    create_records
  end

  private

  def create_leaderboard
    @leaderboard = Leaderboard.create!(name: name, season: @season)
  end

  def create_records
    User.all.map do |user|
      Record.create_for_user_and_leaderboard(user, @leaderboard)
    end
  end

  def name
    @name || "Leaderboard - #{formatted_current_time}"
  end

  def formatted_current_time
    Time.now.in_time_zone(TIME_ZONE).strftime(TIME_FORMAT)
  end
end
