require "rails_helper"

RSpec.feature "Dashboard feature", type: :feature do
  context "as an authenticated user" do
    scenario "I can create a game from the dashboard page" do
      user = create(:user, email: "test@example.com", password: "KFBR392")

      sign_in(user)
      visit dashboard_path
      find(".dashboard__new-game-link").click

      expect(page.current_path).to eq(new_game_path)
    end
  end
end
