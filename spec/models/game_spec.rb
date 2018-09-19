require 'rails_helper'

describe Game, type: :model do
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
end
