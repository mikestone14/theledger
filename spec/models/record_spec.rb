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
end
