require "rails_helper"

RSpec.feature "Dashboard feature", type: :feature do
  scenario "with an authenticated user" do
    user = create(:user, email: "test@example.com", password: "KFBR392")
    sign_in(user)

    visit "/dashboard"

    expect(page).to have_content("Dashboard")
  end

  scenario "with an unauthenticated user" do
    visit "/dashboard"

    expect(page.current_path).to eq(login_path)
  end
end
