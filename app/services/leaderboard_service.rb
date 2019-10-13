class LeaderboardService
  TIME_ZONE = "America/New_York".freeze
  TIME_FORMAT = "%m/%d/%y @ %I:%M%p EST".freeze

  def self.run(name: nil, season: Season.active_season, send_email: true)
    new(name, season, send_email).run
  end

  def initialize(name, season, send_email)
    @name = name
    @season = season
    @send_email = send_email
  end

  def run
    create_leaderboard
    create_records
    send_email
  end

  private

  def create_leaderboard
    @leaderboard = Leaderboard.create!(name: name, season: @season)
  end

  def create_records
    User.active.each do |user|
      Record.create_for_user_and_leaderboard(user, @leaderboard)
    end
  end

  def name
    @name || "Leaderboard - #{formatted_current_time}"
  end

  def formatted_current_time
    Time.now.in_time_zone(TIME_ZONE).strftime(TIME_FORMAT)
  end

  def send_email
    LeaderboardMailer.leaderboard_created(@leaderboard).deliver_now if @send_email
  end
end
