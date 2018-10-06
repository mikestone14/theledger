module LeaderboardsHelper
  def formatted_win_average(win_average)
    win_average
      .round(3)
      .to_s
      .ljust(5, "0")
  end
end
