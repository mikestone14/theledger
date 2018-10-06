require 'rails_helper'

describe Leaderboard, type: :model do
  describe "associations" do
    it { should belong_to(:season) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
