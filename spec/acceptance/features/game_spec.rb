require "rails_helper"

RSpec.feature "Game feature", type: :feature do
  before { create(:season, :active) }

  context "as an authenticated user" do
    context "creating a game" do
      scenario "with valid data" do
        user = create(:user, email: "test@example.com", password: "KFBR392")
        loser = create(:user, name: "Loser")

        sign_in(user)
        visit new_game_path
        select user.name, from: "Winner"
        select loser.name, from: "Loser"
        fill_in "Game price ($)", with: 12.34
        click_on "Submit"

        expect(page).to have_content("Game recorded.")
        expect(page.current_path).to eq(dashboard_path)
      end

      scenario "I can play a $0.50 game" do
        user = create(:user, email: "test@example.com", password: "KFBR392")
        loser = create(:user, name: "Loser")

        sign_in(user)
        visit new_game_path
        select user.name, from: "Winner"
        select loser.name, from: "Loser"
        fill_in "Game price ($)", with: 0.5
        click_on "Submit"

        expect(page).to have_content("Game recorded.")
        expect(page.current_path).to eq(dashboard_path)
      end

      scenario "with invalid data" do
        user = create(:user, email: "test@example.com", password: "KFBR392")
        loser = create(:user, name: "Loser")

        sign_in(user)
        visit new_game_path
        select user.name, from: "Winner"
        select loser.name, from: "Loser"
        click_on "Submit"

        expect(page.current_path).to eq(games_path)
        expect(page).to have_content("Price in cents can't be blank")
      end
    end

    context "viewing the active season's games" do
      scenario "I see the games played in the active season" do
        inactive_season = create(:season, :inactive)
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
        create_list(
          :game,
          2,
          winner: user,
          loser: loser,
          price_in_cents: 1000,
          season: inactive_season,
        )

        sign_in(user)
        visit season_games_path(Season.active_season)

        expect(page).to have_css(".active-season-games-table tbody tr", count: 6)
      end
    end
  end

  context "as an unauthenticated user" do
    scenario "I am redirected to the login page" do
      visit new_game_path

      expect(page.current_path).to eq(login_path)
    end
  end
end
