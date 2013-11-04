#encoding: utf-8
require 'spec_helper'

feature "Users authentication" do
  given(:member) {create(:member)}
  background { login member }

  scenario "user login" do
    page.find(".navbar-main").should_not have_link("Intranet")
    page.should have_css(".navbar-intranet")
    current_path.should eq(intranet_path)
  end

  scenario "users cannot login with incorrect credentials" do
    click_link "Déconnexion"
    page.should have_content("Déconnecté.")
    login User.new
    page.should have_content("Identifiant ou mot de passe incorrect.")
  end

  scenario "users edit their profile" do
    click_link "Modifier compte"
    fill_in "Email", with: "another@example.com"
    fill_in "Mot de passe actuel", with: member.password
    click_button "Mettre à jour"
    page.should have_content("Vous avez mis à jour votre compte avec succès.")
  end
end
