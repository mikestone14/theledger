require 'rails_helper'

describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:winning_games) }
    it { is_expected.to have_many(:losing_games) }
  end

  describe "validations" do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe "#active_season_game_count" do
    it "returns the number of games the user has either won or lost in the active season" do
      season = create(:season, :active)
      user = create(:user)
      create_list(:game, 2, season: season)
      create_list(:game, 2, season: season, winner: user)
      create_list(:game, 2, season: season, loser: user)
      create(:game)
      create_list(:game, 2, winner: user)
      create_list(:game, 2, loser: user)

      expect(user.active_season_game_count).to eq(4)
    end
  end

  describe "#game_count" do
    it "returns the number of game either won or lost" do
      season = create(:season, :active)
      user = create(:user)
      create_list(:game, 2, season: season, winner: user)
      create(:game, season: season, loser: user)

      expect(user.game_count).to eq(3)
    end
  end
end
