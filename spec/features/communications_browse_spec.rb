require 'spec_helper'

feature 'User browsing communications' do
  let!(:user) {build_stubbed :approved_user}

  background do
    login user
    create_list(:communication, 10)
    create_list(:unpublished_communication, 2)
    visit admin_communications_path
  end

  scenario 'cannot see unpublished communications' do
    page.should_not have_content('unpublished')
  end

  scenario 'cannot see admin actions' do
    page.should_not have_content('Modifier')
    page.should_not have_content('Détruire')
    page.should_not have_content('Nouveau')
  end

  scenario 'can see communication details' do
    visit admin_communication_path(Communication.published.first)
  end
end
