require "rails_helper"

describe LeaderboardService do
  describe ".run" do
    it "creates a leaderboard" do
      setup_data

      expect { LeaderboardService.run(name: "New Leaderboard", season: @season) }
        .to change { Leaderboard.count }.from(0).to(1)
      expect(Leaderboard.last).to have_attributes(
        name: "New Leaderboard",
        season: @season,
      )
    end

    it "adds records to the leaderboard" do
      setup_data
      LeaderboardService.run(name: "Leaderboard", season: @season)
      leaderboard = Leaderboard.last

      expect(leaderboard.records).to contain_exactly(
        an_object_having_attributes(
          user: @mike,
          win_count: 2,
          loss_count: 1,
          net_in_cents: 2050,
        ),
        an_object_having_attributes(
          user: @chris,
          win_count: 2,
          loss_count: 2,
          net_in_cents: -300,
        ),
        an_object_having_attributes(
          user: @jessi,
          win_count: 1,
          loss_count: 2,
          net_in_cents: -1750,
        ),
      )
    end

    it "sets a default leaderboard name" do
      setup_data
      current_time = Time
        .zone
        .local(2017, 12, 24, 13, 30, 10)

      travel_to(current_time) do
        LeaderboardService.run(season: @season)
        leaderboard = Leaderboard.last

        expect(leaderboard).to have_attributes(
          name: "Leaderboard - 12/24/17 @ 01:30PM EST",
        )
      end
    end

    it "uses the active season by default" do
      setup_data
      LeaderboardService.run
      leaderboard = Leaderboard.last

      expect(leaderboard).to have_attributes(
        season: @season,
      )
    end

    it "sends a leaderboard created email when send_email is true" do
      setup_data

      expect { LeaderboardService.run(season: @season, send_email: true) }
        .to change { ActionMailer::Base.deliveries.count }.from(0).to(1)
    end

    it "does not send a leaderboard created email when send_email is false" do
      setup_data

      expect { LeaderboardService.run(season: @season, send_email: false) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end

  def setup_data
    @mike = create(:user, name: "Mike")
    @chris = create(:user, name: "Chris")
    @jessi = create(:user, name: "Jessi")
    @season = create(:season, :active)

    create_list(
      :game,
      2,
      winner: @mike,
      loser: @chris,
      price_in_cents: 1050,
      season: @season,
    )

    create_list(
      :game,
      2,
      winner: @chris,
      loser: @jessi,
      price_in_cents: 900,
      season: @season,
    )

    create(
      :game,
      winner: @jessi,
      loser: @mike,
      price_in_cents: 50,
      season: @season,
    )
  end
end
