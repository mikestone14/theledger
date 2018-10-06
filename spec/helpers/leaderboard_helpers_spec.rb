require "rails_helper"

describe LeaderboardsHelper, type: :helper do
  describe "#formatted_win_average" do
    it "returns the win average in a consistent format" do
      expect(formatted_win_average(0.1)).to eq("0.100")
      expect(formatted_win_average(0.25)).to eq("0.250")
      expect(formatted_win_average(0.3333333)).to eq("0.333")
    end
  end
end
