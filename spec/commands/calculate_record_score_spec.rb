require "rails_helper"

describe CalculateRecordScore do
  describe ".call" do
    it "calculates the score" do
      win_count = 10
      loss_count = 4
      net_in_cents = 25_000

      score = CalculateRecordScore.call(
        win_count: win_count,
        loss_count: loss_count,
        net_in_cents: net_in_cents,
      )

      expect(score).to eq(56)
    end
  end
end
