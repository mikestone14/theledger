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
  end

  context "as an unauthenticated user" do
    scenario "I am redirected to the login page" do
        visit new_game_path

        expect(page.current_path).to eq(login_path)
    end
  end
end
