require "spec_helper"

feature "Coordonnées management" do

  let!(:admin)      {create(:admin)}
  let!(:coordonnee) {create(:coordonnee)}

  background do
    login admin
  end

  scenario "creation" do
    visit new_coordonnee_path
    fill_in "coordonnee_libelle", with: ""
    click_on "Enregistrer"
    page.should have_content "erreurs"
    fill_in "coordonnee_libelle", with: "ddpp"
    click_on "Enregistrer"
    page.should have_content "succès"
  end

  scenario "edit" do
    visit edit_coordonnee_path(coordonnee)
    fill_in "coordonnee_libelle", with: ""
    click_on "Enregistrer"
    page.should have_content "erreurs"
    fill_in "coordonnee_libelle", with: "ddpp"
    click_on "Enregistrer"
    page.should have_content "succès"
  end
end
