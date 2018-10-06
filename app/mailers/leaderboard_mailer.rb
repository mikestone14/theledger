class LeaderboardMailer < ApplicationMailer
  def leaderboard_created(leaderboard)
    @leaderboard = leaderboard
    user_emails = User.pluck(:email)

    mail(to: user_emails, subject: "New leaderboard created")
  end
end
