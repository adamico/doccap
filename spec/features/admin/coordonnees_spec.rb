require "spec_helper"

feature "Coordonnées management" do

  let!(:admin)      { create(:admin) }
  let!(:coordonnee) { create(:coordonnee)}
  let(:range)       { (1001..1010) }

  background do
    login admin
    range.each do |i|
      create(:coordonnee, libelle: "coordonnee#{i}")
    end
    create_list(:coord_category, 10)
  end

  scenario "creation" do
    visit new_admin_coordonnee_path
    fill_in "coordonnee_libelle", with: ""
    fill_in "coordonnee_content", with: ""
    click_on "Enregistrer"
    page.should have_content(/erreur/)
    fill_in "coordonnee_libelle", with: "ddpp"
    content = "Bla, bla and bla"
    fill_in "coordonnee_content", with: content
    click_on "Enregistrer"
    page.should have_content "succès"
    page.should have_content content
  end

  scenario "edit" do
    visit edit_admin_coordonnee_path(coordonnee)
    fill_in "coordonnee_libelle", with: ""
    click_on "Enregistrer"
    page.should have_content(/erreur/)
    fill_in "coordonnee_libelle", with: "ddpp"
    click_on "Enregistrer"
    page.should have_content "succès"
  end

  scenario "browse coordonnees" do
    visit admin_coordonnees_path
    range.each do |i|
      page.should have_content "coordonnee#{i}"
    end
  end

end
