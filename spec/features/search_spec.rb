require "spec_helper"

feature "Search" do
  given(:user) {create(:user)}

  background do
    login user
  end

  scenario "returns results in vigitox articles" do
    pending
  end

  scenario "returns results in communications records with js", js: true do
    visit root_path
    fill_in "query", with: "cyanures"
    click_on "OK"
    page.should have_content "Colloque"
    page.should have_content "les cyanures"
  end
end
