require "rails_helper"

RSpec.describe LeaderboardMailer, type: :mailer do
  describe "#leaderboard_created" do
    it "sends an email with a link to the new leaderboard" do
      leaderboard = create(:leaderboard)
      email = LeaderboardMailer.leaderboard_created(leaderboard)

      expect(email).to have_attributes(
        from: ["hi@example.com"],
        to: User.pluck(:email),
        subject: "New leaderboard created"
      )

      expect(email.body.to_s).to include(
        "<a href=\"http://example.com/leaderboards/#{leaderboard.id}\">View the leaderboard</a>"
      )
    end
  end
end
