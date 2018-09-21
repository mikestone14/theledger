require "rails_helper"

RSpec.feature "Dashboard feature", type: :feature do
  context "as an authenticated user" do
    scenario "I can view the dashboard page" do
      user = create(:user, email: "test@example.com", password: "KFBR392")
      sign_in(user)

      visit dashboard_path

      expect(page.current_path).to eq(dashboard_path)
    end
  end

  context "as an unauthenticated user" do
    scenario "I am redirected to the login page" do
      visit dashboard_path

      expect(page.current_path).to eq(login_path)
    end
  end
end
