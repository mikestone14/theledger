require "rails_helper"

RSpec.feature "Seasons", type: :feature do
  before { create(:season, :active, name: "Active season") }

  context "as an authenticated user" do
    scenario "I can view a list of seasons" do
      create(:season, :inactive, name: "Inactive season")
      user = create(:user)
      sign_in(user)
      visit seasons_path

      within(".collection") do
        expect(page).to have_text("Active season")
        expect(page).to have_text("Inactive season")
      end
    end

    scenario "I can activate a season as an admin" do
      inactive_season = create(:season, :inactive, name: "Inactive season")
      user = create(:user, :admin)
      sign_in(user)
      visit seasons_path

      within(".collection #season-#{inactive_season.id}") do
        click_on "activate"
      end

      expect(inactive_season.reload).to be_active
    end

    scenario "I cannot activate a season as a non-admin" do
      inactive_season = create(:season, :inactive, name: "Inactive season")
      user = create(:user)
      sign_in(user)
      visit seasons_path

      within(".collection #season-#{inactive_season.id}") do
        expect(page).not_to have_text("activate")
      end
    end
  end
end
