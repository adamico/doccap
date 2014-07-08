require 'spec_helper'

feature "Users authentication" do
  given(:user) {create(:user)}

  scenario "unapproved users can't login" do
    visit login_path
    page.should have_content("entrer email et mot de passe")
    login user
    page.should have_content(/pas encore été approuvé/i)
  end

  scenario "approved users can login" do
    user.approved!
    visit root_path
    login user
    page.should have_content(/connecté/i)
  end

  scenario "users cannot login with incorrect credentials" do
    login User.new
    page.should have_content(/identifiant ou mot de passe incorrect/i)
  end
end
