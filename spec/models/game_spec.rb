require "rails_helper"

describe Game, type: :model do
  it { is_expected.to define_enum_for(:status).with_values([:active, :nullified]) }

  describe "associations" do
    it { is_expected.to belong_to(:season) }
    it { is_expected.to belong_to(:winner).class_name(:User) }
    it { is_expected.to belong_to(:loser).class_name(:User) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:season) }
    it { is_expected.to validate_presence_of(:winner) }
    it { is_expected.to validate_presence_of(:loser) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
  end

  describe "#price_in_dollars" do
    it "returns the price in dollars" do
      game = create(:game, price_in_cents: 1234)

      expect(game.price_in_dollars).to eq(12.34)
    end
  end
end
