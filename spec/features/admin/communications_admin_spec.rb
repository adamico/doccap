require "spec_helper"

feature "Admin can manage communications" do

  let!(:admin)    {create(:admin)}
  let!(:category) {create(:category)}

  background do
    login admin
    create_list(:communication, 10)
  end

  scenario "browse communications" do
    visit communications_path
  end

  scenario "create communication", focus: true do
    visit communications_path
    click_on "Nouveau document"
    click_on "Enregistrer"
    page.should have_content "erreurs"
    fill_in "communication_titre", with: "le titre"
    fill_in "communication_publication", with: "01/01/2013"
    select category.name, from: "communication_category_id"
    check "Publié?"
    click_on "Enregistrer"
    page.should have_content "succès"
  end
end
