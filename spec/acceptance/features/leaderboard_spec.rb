require "rails_helper"

RSpec.feature "Leaderboard feature", type: :feature do
  before { create(:season, :active) }

  context "as an authenticated user" do
    scenario "I can view a list of the season's leaderboards" do
      user = create(:user)
      create(:leaderboard, name: "Leaderboard 1", season: Season.active_season)
      create(:leaderboard, name: "Leaderboard 2", season: Season.active_season)
      sign_in(user)
      visit season_leaderboards_path(Season.active_season)

      within(".leaderboards__list") do
        expect(page).to have_text("Leaderboard 1")
        expect(page).to have_text("Leaderboard 2")
      end
    end

    scenario "when I click 'Create Leaderboard' a new leaderboard is created" do
      admin = create(:user, :admin)
      sign_in(admin)
      visit season_leaderboards_path(Season.active_season)

      expect { click_on("Create Leaderboard") }.to change { Leaderboard.count }.from(0).to(1)
    end

    scenario "when I click on a leaderboard I can view that leaderboard" do
      user = create(:user)
      leaderboard = create(:leaderboard, name: "Leaderboard 1", season: Season.active_season)
      create(:leaderboard, name: "Leaderboard 2", season: Season.active_season)
      sign_in(user)
      visit season_leaderboards_path(Season.active_season)
      click_on("Leaderboard 1")

      expect(page.current_path).to eq leaderboard_path(leaderboard)
    end

    scenario "viewing a leaderboard" do
      user = create(:user)
      ineligible_user = create(:user)
      leaderboard = create(
        :leaderboard,
        name: "Leaderboard 1",
        season: Season.active_season,
      )
      create(:record, leaderboard: leaderboard, user: user, win_count: 25)
      create(
        :record,
        leaderboard: leaderboard,
        user: ineligible_user,
        win_count: 10,
        loss_count: 10,
      )
      sign_in(user)
      visit leaderboard_path(leaderboard)

      within(".leaderboard__table-wrapper--eligible") do
        expect(page).to have_content(user.name)
      end

      within(".leaderboard__table-wrapper--ineligible") do
        expect(page).to have_content(ineligible_user.name)
      end
    end
  end

  context "as an authenticated user" do
    scenario "I am redirected to the login page" do
      visit season_leaderboards_path(Season.active_season)

      expect(page.current_path).to eq(login_path)
    end
  end
end
