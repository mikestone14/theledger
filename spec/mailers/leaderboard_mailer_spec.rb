require "rails_helper"

RSpec.describe LeaderboardMailer, type: :mailer do
  describe "#leaderboard_created" do
    it "sends an email to active users with a link to the new leaderboard" do
      create(:user, :inactive)
      active_user = create(:user, :active)
      leaderboard = create(:leaderboard)
      email = LeaderboardMailer.leaderboard_created(leaderboard)

      expect(email).to have_attributes(
        from: ["hi@example.com"],
        to: [active_user.email],
        subject: "New leaderboard created"
      )

      expect(email.body.to_s).to include(
        "<a href=\"http://example.com/leaderboards/#{leaderboard.id}\">View the leaderboard</a>"
      )
    end
  end
end
