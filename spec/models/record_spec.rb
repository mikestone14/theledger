require "rails_helper"

describe Record, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:leaderboard) }
    it { is_expected.to belong_to(:user) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:win_count) }
    it { is_expected.to validate_presence_of(:loss_count) }
    it { is_expected.to validate_presence_of(:net_in_cents) }
  end

  describe ".create_for_user_and_leaderboard" do
    it "creates a record with the expected attributes" do
      leaderboard = create(:leaderboard)
      user = create(:user)
      create_list(:game, 2, season: leaderboard.season, winner: user, price_in_cents: 100)
      create_list(:game, 1, season: leaderboard.season, loser: user, price_in_cents: 75)

      record = Record.create_for_user_and_leaderboard(user, leaderboard)

      expect(record).to have_attributes(
        win_count: 2,
        loss_count: 1,
        net_in_cents: 125,
      )
    end
  end
end
