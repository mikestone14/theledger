require 'rails_helper'

describe Season, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }

    it do
      is_expected.to define_enum_for(:status).with([:active, :inactive])
    end

    it "is not valid with more than 1 active season" do
      create(:season, :active)
      active_season = build(:season, :active)

      expect(active_season).not_to be_valid
      expect(active_season.errors).to contain_exactly(
        "Status can only be active in one season"
      )
    end
  end

  describe ".current_season" do
    it "returns the active season" do
      create(:season, :inactive)
      active_season = create(:season, :active)
      create(:season, :inactive)

      expect(Season.active_season).to eq(active_season)
    end
  end
end
