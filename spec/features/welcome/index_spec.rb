require 'rails_helper'

RSpec.describe 'Welcome Index' do
  @users = let!(:users) { create_list(:user, 3) }
  before :each do
    visit '/'
  end

  describe 'When a user visits the root path they should be on the landing page' do
    it 'includes title of application and a button to create a new user' do
      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_button('Create a New User')
    end

    it 'shows a list of existing users which links to the users dashboard' do
      user1 = users[0]
      user2 = users[1]
      user3 = users[2]

      expect(page).to have_link(user1.name)
      expect(page).to have_link(user2.name)
      expect(page).to have_link(user3.name)

      click_link user1.name.to_s

      expect(current_path).to eq(user_path(user1.id))
    end

    it 'links back to the landing page (this link will be present at the top of all pages' do
      expect(page).to have_link('Home')

      click_link 'Home'

      expect(current_path).to eq(root_path)
    end

    # As a registered user
    # When I visit the landing page `/`
    # I see a link for "Log In"
    # When I click on "Log In"
    # I'm taken to a Log In page ('/login') 
    it 'has a link to Log In' do 
      click_link 'Log In' 

      expect(current_path).to eq '/login'
    end
  end
end
