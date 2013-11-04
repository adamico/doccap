require 'spec_helper'

feature "Users authentication" do
  given(:user) {create(:user)}

  scenario "user must login" do
    visit root_path
    page.should have_content "devez vous connecter"
    login user
    page.should have_content /connecté/i
  end

  scenario "users cannot login with incorrect credentials" do
    login User.new
    page.should have_content /identifiant ou mot de passe incorrect/i
  end
end
