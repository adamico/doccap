require "spec_helper"

feature "Search" do
  given(:user) {create(:user)}

  background do
    login user
    colloque = create(:category, name: "colloque")
    create(:communication, titre: "les cyanures", category: colloque, published: "oui")
    create(:communication, titre: "les machins", category: colloque, published: "oui", tags: "cyanures")
  end

  scenario "returns results in vigitox articles" do
    pending
  end

  scenario "returns results in communications records with js", js: true, slow: true do
    visit biblio_path
    fill_in "query", with: "cyanures"
    click_on "OK"
    page.should have_content "colloque"
    page.should have_content "les cyanures"
    page.should have_content "les machins"
  end
end
