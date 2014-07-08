require "spec_helper"

feature "Admin can manage communications" do

  let!(:admin)    {create(:admin)}
  let!(:category) {create(:category)}

  background do
    login admin
    create_list(:communication, 10)
  end

  scenario "browse communications" do
    visit admin_communications_path
  end

  scenario "create communication" do
    pending "category select2 to be tested"
    visit admin_communications_path
    click_on "Nouveau document"
    click_on "Enregistrer"
    page.should have_content "erreur"
    fill_in "communication_title", with: "le titre"
    fill_in "communication_publication", with: "01/01/2013"
    select "Oui", from: "communication_published"
    click_on "Enregistrer"
    page.should have_content "succès"
    page.current_path.should == admin_communications_path
  end

  scenario "add new category", js: true do
    visit new_admin_communication_path
    click_on "Nouvelle catégorie"
    within ".modal" do
      fill_in "category_name", with: "lacat"
      click_on "Enregistrer"
    end
    page.should have_content "lacat"
  end

  scenario "edit category", js: true do
    visit new_admin_communication_path
    click_on "Nouvelle catégorie"
    within ".modal" do
      fill_in "category_name", with: "lacat"
      click_on "Enregistrer"
    end
    click_on "Modifier catégorie"
    within ".modal" do
      fill_in "category_name", with: "lautrecat"
      click_on "Enregistrer"
    end
    page.should have_content "lautrecat"
  end

  scenario "edit communication" do
    visit edit_admin_communication_path(Communication.first)
    fill_in "communication_title", with: ""
    click_on "Enregistrer"
    page.should have_content "erreur"
    fill_in "communication_title", with: "le titre"
    click_on "Enregistrer"
    page.should have_content "succès"
    page.current_path.should == admin_communications_path
  end

  scenario "add tags" do
    pending
  end

  scenario "attach/unattach file" do
    pending
  end
end
