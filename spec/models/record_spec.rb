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

  describe ".eligible" do
    it "returns records with >= 25 games played" do
      eligible_game1 = create(:record, win_count: 24, loss_count: 1)
      create(:record, win_count: 24, loss_count: 0)
      eligible_game2 = create(:record, win_count: 25, loss_count: 0)

      expect(Record.eligible).to contain_exactly(eligible_game1, eligible_game2)
    end
  end

  describe ".ineligible" do
    it "returns records with < 25 games played" do
      create(:record, win_count: 24, loss_count: 1)
      ineligible_game = create(:record, win_count: 24, loss_count: 0)
      create(:record, win_count: 25, loss_count: 0)

      expect(Record.ineligible).to contain_exactly(ineligible_game)
    end
  end

  describe ".by_score_and_win_average" do
    it "returns the records ordered by win average in descending order" do
      mike = create(:record, win_count: 21, loss_count: 12, score: 10)
      bone = create(:record, win_count: 6, loss_count: 4, score: 8)
      chris = create(:record, win_count: 8, loss_count: 9, score: 6)
      jessi = create(:record, win_count: 2, loss_count: 7, score: 4)
      gia = create(:record, win_count: 6, loss_count: 11, score: 7)
      jeff = create(:record, win_count: 8, loss_count: 2, score: 9)
      matt = create(:record, win_count: 5, loss_count: 11, score: 5)

      expect(Record.by_score_and_win_average).to eq([
        mike,
        jeff,
        bone,
        gia,
        chris,
        matt,
        jessi,
      ])
    end
  end

  describe ".create_for_user_and_leaderboard" do
    it "creates a record with the expected attributes, not including nullified games" do
      leaderboard = create(:leaderboard)
      user = create(:user)
      create_list(:game, 2, season: leaderboard.season, winner: user, price_in_cents: 100)
      create_list(:game, 2, :nullified, season: leaderboard.season, winner: user, price_in_cents: 100)
      create_list(:game, 1, season: leaderboard.season, loser: user, price_in_cents: 75)
      create_list(:game, 1, :nullified, season: leaderboard.season, loser: user, price_in_cents: 75)

      record = Record.create_for_user_and_leaderboard(user, leaderboard)

      expect(record).to have_attributes(
        win_count: 2,
        loss_count: 1,
        net_in_cents: 125,
        score: 1.25,
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
    it "returns 0 when no games played" do
      record = build_stubbed(:record, win_count: 0, loss_count: 0)

      expect(record.win_average).to be_zero
    end

    it "returns the win average" do
      record = build_stubbed(:record, win_count: 75, loss_count: 25)

      expect(record.win_average).to eq(0.750)
    end
  end
end
