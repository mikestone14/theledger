module FeatureHelper
  def sign_in(user = nil)
    @user = user || create(:user)

    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "KFBR392"
    click_button "Log in"
  end
end
