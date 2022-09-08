require 'rails_helper'

RSpec.describe 'Welcome Index' do
  @users = let!(:users) { create_list(:user, 3) }

  describe 'When a user visits the root path they should be on the landing page' do
    it 'includes title of application and a button to create a new user' do
      visit '/'
      
      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_button('Create a New User')
    end

    it 'shows a list of existing users which links to the users dashboard' do      
      user1 = users[0]
      user2 = users[1]
      user3 = users[2]

      visit '/'

      expect(page).to have_link(user1.name)
      expect(page).to have_link(user2.name)
      expect(page).to have_link(user3.name)

      click_link user1.name.to_s

      expect(current_path).to eq(user_path(user1.id))
    end

    it 'links back to the landing page (this link will be present at the top of all pages' do
      visit '/'
      
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
      visit '/'
      
      click_link 'Log In' 

      expect(current_path).to eq '/login'
    end

    # As a logged in user 
    # When I visit the landing page
    # I no longer see a link to Log In or Create an Account
    # But I see a link to Log Out.
    # When I click the link to Log Out
    # I'm taken to the landing page
    # And I can see that the Log Out link has changed back to a Log In link
    it 'has a Log Out link but no Log In or Create an Account link' do 
      user1 = users[0]

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/'

      expect(page).to_not have_link('Log In')
      expect(page).to_not have_button('Create a New User')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

      click_link 'Log Out' 

      expect(current_path).to eq root_path
      expect(page).to have_link('Log In')
      expect(page).to have_button('Create a New User')
    end

    # As a visitor
    # When I visit the landing page
    # And then try to visit '/dashboard'
    # I remain on the landing page
    # And I see a message telling me that I must be logged in or registered to access my dashboard
    it 'requires the user to be logged in or register to visit the dashboard' do 
      visit '/'

      visit '/dashboard' 

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in or registered to access the dashboard.')
    end
  end
end
