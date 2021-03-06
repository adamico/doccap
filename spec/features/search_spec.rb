require "spec_helper"

feature "Search" do
  given(:user) {create(:approved_user)}

  background do
    login user
    colloque = create(:category, name: "colloque")
    create(:communication, title: "les cyanures", category: colloque, state: 'published')
    create(:communication, title: "les machins", category: colloque, state: 'published', tag_list: "cyanures")
  end

  scenario "returns results in vigitox articles" do
    pending
  end

  scenario "returns results in communications records with js", js: true do
    pending "redo this"
    visit biblio_path
    fill_in "query", with: "cyanures"
    click_on "OK"
    page.should have_content "colloque"
    page.should have_content "les cyanures"
    page.should have_content "les machins"
  end
end
