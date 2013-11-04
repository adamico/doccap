require 'spec_helper'

feature "Users authentication" do
  given(:user) {create(:user)}
  background { login user }

  scenario "user login" do
    page.should have_content /connecté/i
  end

  scenario "users cannot login with incorrect credentials" do
    visit logout_path
    page.should have_content /déconnecté/i
    login User.new
    page.should have_content /identifiant ou mot de passe incorrect/i
  end
end
