#encoding: utf-8
require "spec_helper"

feature "Users admin" do
  given(:admin) {create(:admin)}
  background {login admin}

  scenario "approving users" do
    visit admin_users_path
    page.should_not have_link("utilisateurs non approuvés")
    unapproved = create(:user, email: "unapproved1@example.com")
    visit admin_users_path
    click_link("utilisateurs non approuvés")
    within ".users" do
      page.should have_content("unapproved1")
      page.should_not have_content("admin1")
    end
    within "#user_#{unapproved.id}" do
      click_link "Approuver"
    end
    page.should have_content("Utilisateur '#{unapproved.email}' approuvé avec succès.")
    within "#user_#{unapproved.id}" do
      page.should_not have_content "Approuver"
    end
  end

  scenario "can edit users details" do
    other_user = create(:user)
    visit admin_users_path(approved: false)
    within "#user_#{other_user.id}" do
      click_link "Modifier"
    end
    fill_in "Email", with: "lambda@test.com"
    fill_in "Mot de passe actuel", with: other_user.password
    click_button "Enregistrer"
    page.should have_content "L'utilisateur lambda@test.com a été modifié avec succès."
  end

  scenario "can destroy users" do
    other_user = create(:user)
    visit admin_users_path
    within "#user_#{other_user.id}" do
      click_link "Détruire"
    end
    page.should_not have_content other_user.email
  end

  scenario "cannot destroy his own record" do
    visit admin_users_path
    within "#user_#{admin.id}" do
      page.should_not have_content "Détruire"
    end
  end

  scenario "can assign users roles" do
    role = create(:role)
    member = create(:member)
    visit edit_admin_user_path(member)
    check role.name
    click_button "Enregistrer"
    page.should have_content role.name
  end
end
