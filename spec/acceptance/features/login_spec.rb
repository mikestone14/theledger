require "rails_helper"

RSpec.feature "Login feature", type: :feature do
  scenario "successful log in" do
    user = create(:user, email: "test@example.com", password: "KFBR392")

    sign_in(user)

    expect(page.current_path).to eq(dashboard_path)
  end

  scenario "unsuccessful log in" do
    user = create(:user)

    visit "/login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "invalid-password"
    click_button "Log in"

    expect(page.current_path).to eq(login_path)
  end

  scenario "when the user is already logged in it redirects to the dashboard page" do
    user = create(:user, email: "test@example.com", password: "KFBR392")

    sign_in(user)
    visit "/login"

    expect(page.current_path).to eq(dashboard_path)
  end
end
