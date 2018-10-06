require "rails_helper"

describe Leaderboard, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:season) }
    it { is_expected.to have_many(:records) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
