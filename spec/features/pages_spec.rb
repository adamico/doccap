require 'spec_helper'

feature "Pages" do
  scenario "try to access a restricted page" do
    visit intranet_path
    page.should have_content("connecter")
  end

  scenario "raises record not found when accessing a page with missing parents" do
    orphan_page = create(:published)
    visit "/father/#{orphan_page.name}"
    page.should have_content("Page non trouvée !")
  end

  scenario "can access published pages" do
    create(:published, name: "lapage")
    visit "/lapage"
    page.should have_content("lapage")
  end

  scenario "can access pages with ancestors" do
    child = create(:published, name: "child")
    father = create(:published, name: "father")
    gfather = create(:published, name: "gfather")
    child.parent = father
    father.parent = gfather
    child.save
    father.save
    visit "/gfather/father/child"
    page.should have_content "child"
  end

  describe "with draft status" do
    given(:admin) {create(:admin)}

    scenario "cannot be publicly viewed" do
      draft_page = create(:draft)
      visit "/#{draft_page.name}"
      page.should have_content("Page non trouvée !")
    end

    scenario "can be viewed by admin" do
      login admin
      draft_page = create(:draft)
      visit "/#{draft_page.name}"
      page.should_not have_content("Page non trouvée !")
    end
  end
end
