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

  describe ".by_win_average" do
    it "returns the records ordered by win average in descending order" do
      first_record = create(:record, win_count: 3, loss_count: 1)
      second_record = create(:record, win_count: 25, loss_count: 25)
      last_record = create(:record, win_count: 2, loss_count: 3)

      expect(Record.by_win_average).to eq([
        first_record,
        second_record,
        last_record,
      ])
    end
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

  describe "#net_in_dollars" do
    it "returns the net winnings in dollars" do
      record = build_stubbed(:record, net_in_cents: 1050)

      expect(record.net_in_dollars).to eq(10.50)
    end
  end

  describe "#games_played" do
    it "returns the win_count plus the loss_count" do
      record = build_stubbed(:record, win_count: 9, loss_count: 2)

      expect(record.games_played).to eq(11)
    end
  end

  describe "#win_average" do
    it "returns the win average" do
      record = build_stubbed(:record, win_count: 75, loss_count: 25)

      expect(record.win_average).to eq(0.750)
    end
  end
end
