require 'rails_helper'

RSpec.describe 'Register User Page', type: :feature do
  describe 'When a user visits the /register path' do
    it 'shows a form to register with a name, unique email, password and password confirmation, and a register button' do
      visit '/register'
      save_and_open_page

      fill_in 'Name', with: ''
      fill_in 'Email', with: '1234'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content 'Error'

      fill_in 'Name', with: 'Sally Smith'
      fill_in 'Email', with: 'sallysmith@gmail.com'
      fill_in 'Password', with: '123abc' 
      fill_in 'Password Confirmation', with: '123abc'
      click_button 'Register User'

      sally = User.all.last
      expect(current_path).to eq user_path(sally.id)
    end
  end

  # As a visitor 
  # When I visit `/register`
  # I see a form to fill in my name, email, password, and password confirmation.
  # When I fill in that form with my name, email, and matching passwords,
  # I'm taken to my dashboard page `/users/:id`
  
end
