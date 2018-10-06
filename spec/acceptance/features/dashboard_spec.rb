require "rails_helper"

RSpec.feature "Dashboard feature", type: :feature do
  before { create(:season, :active) }

  context "as an authenticated user" do
    scenario "I can view the dashboard page" do
      user = create(:user)
      sign_in(user)

      visit dashboard_path

      expect(page.current_path).to eq(dashboard_path)
    end

    scenario "I see the last 6 games played" do
      loser = create(:user, name: "Paul Revere")
      user = create(:user)
      create_list(
        :game,
        6,
        winner: user,
        loser: loser,
        price_in_cents: 1000,
        season: Season.active_season,
      )

      sign_in(user)
      visit dashboard_path

      expect(page).to have_css(".recent-games-table tbody tr", count: 6)
      expect(page).not_to have_link("View all games")
    end

    scenario "I see a link to view all games if there are more than 6 games" do
      loser = create(:user, name: "Paul Revere")
      user = create(:user)
      create_list(
        :game,
        8,
        winner: user,
        loser: loser,
        price_in_cents: 1000,
        season: Season.active_season,
      )

      sign_in(user)
      visit dashboard_path
      click_on("View all games")

      expect(page.current_path).to eq(active_season_games_path)
    end

    scenario "I see the user game counts" do
      loser = create(:user, name: "Paul Revere")
      user = create(:user, name: "Jerry Garcia")
      create_list(
        :game,
        8,
        winner: user,
        loser: loser,
        price_in_cents: 1000,
        season: Season.active_season,
      )
      create(:game, winner: user, price_in_cents: 1000, season: Season.active_season)

      sign_in(user)
      visit dashboard_path

      user_td = page.find(".player-game-count-table td", text: user.name)

      expect(page).to have_css(".player-game-count-table tbody tr", count: 3)
      expect(user_td.sibling("td").text).to eq("9")
    end

    scenario "I see a link to view the current season's leaderboards" do
      user = create(:user)
      sign_in(user)
      visit dashboard_path
      click_on("View current season's leaderboards")

      expect(page.current_path).to eq(active_season_leaderboards_path)
    end
  end

  context "as an unauthenticated user" do
    scenario "I am redirected to the login page" do
      visit dashboard_path

      expect(page.current_path).to eq(login_path)
    end
  end
end
