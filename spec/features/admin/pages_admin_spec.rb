#encoding: utf-8
require 'spec_helper'

feature "Pages admin" do
  background {login create(:page_manager)}

  scenario "views pages with draft status" do
    draft_page = create(:draft)
    visit "/#{draft_page.name}"
    page.should have_content("Cette page n'a pas été publiée.")
  end

  scenario "pages tree" do
    pending "implement me!"
  end

  scenario "pages reordering" do
    pending "implement me!"
  end

  scenario "creates pages" do
    visit new_admin_page_path
    page.should_not have_content("Vous n'êtes pas authorisé à voir cette page.")
    click_button "Enregistrer"
    page.should have_content("Veuillez corriger les champs suivant :")
    fill_in "page_name", with: "Le titre"
    fill_in "page_content", with: "<p>Paragraphe de test</p>"
    click_button "Enregistrer"
    page.should have_content("Page 'Le titre' créée avec succès.")
  end

  scenario "updates a page" do
    pending "why the hell"
    existing_page = create(:page)
    visit edit_admin_page_path(existing_page)
    fill_in "page_name", with: ""
    click_button "Enregistrer"
    page.should have_content("Veuillez corriger les champs suivant :")
    fill_in "page_name", with: "Un autre titre"
    click_button "Enregistrer"
    page.should have_content("Page 'Un autre titre' mise à jour avec succès.")
  end

  scenario "destroys a page" do
    existing_page = create(:page, name: "bidule")
    visit page_path(existing_page)
    click_link "Détruire"
    page.should have_content("Page 'bidule' détruite avec succès.")
  end
end