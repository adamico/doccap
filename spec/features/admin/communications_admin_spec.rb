require "spec_helper"

feature "Admin can manage communications" do

  let!(:admin) {create(:admin)}

  background do
    login admin
    create_list(:communication, 10)
  end

  scenario "browse communications" do
    visit communications_path
  end
end
