require "spec_helper"

feature "User browsing coordonnees" do
  let!(:user) { create :approved_user }

  background do
    login user
    create_list(:coordonnee, 10)
    #create_list(:unpublished_coordonnee, 2)
  end

  scenario "can access list" do
    visit coordonnees_path
  end

  scenario "can see coordonnee details" do
    visit coordonnee_path(Coordonnee.first)
  end
end
