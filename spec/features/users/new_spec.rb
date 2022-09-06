require 'rails_helper'

RSpec.describe 'Register User Page', type: :feature do
  describe 'When a user visits the /register path' do
    # As a visitor 
    # When I visit `/register`
    # I see a form to fill in my name, email, password, and password confirmation.
    # When I fill in that form with my name, email, and matching passwords,
    # I'm taken to my dashboard page `/users/:id`
    it 'shows a form to register with a name, unique email, password and password confirmation, and a register button' do
      visit '/register'

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

    # As a visitor 
    # When I visit `/register`
    # and I fail to fill in my name, unique email, OR matching passwords,
    # I'm taken back to the `/register` page
    # and a flash message pops up, telling me what went wrong
    it 'takes user back to the registration page if they fail to fill in name, unique email, or matching passwords' do 
      visit '/register'

      # fill_in 'Name', with: ''
      # fill_in 'Email', with: 'sallysmith@gmail.com'
      # fill_in 'Password', with: '123abc' 
      # fill_in 'Password Confirmation', with: '123abc'
      # click_button 'Register User'

      # expect(current_path).to eq '/register'
      # expect(page).to have_content "Error: Name can't be blank"

      # fill_in 'Name', with: 'Sally Smith'
      # fill_in 'Email', with: ''
      # fill_in 'Password', with: '123abc' 
      # fill_in 'Password Confirmation', with: '123abc'
      # click_button 'Register User'

      # expect(current_path).to eq '/register'
      # expect(page).to have_content "Error: Email is invalid"

      # fill_in 'Name', with: 'Sally Smith'
      # fill_in 'Email', with: 'sallysmith@gmail.com'
      # fill_in 'Password', with: '' 
      # fill_in 'Password Confirmation', with: ''
      # click_button 'Register User'

      # expect(current_path).to eq '/register'
      # expect(page).to have_content "Error: Password can't be blank"

      fill_in 'Name', with: 'Sally Smith'
      fill_in 'Email', with: 'sallysmith@gmail.com'
      fill_in 'Password', with: 'abc' 
      fill_in 'Password Confirmation', with: '123'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content "Error: Passwords do not match."
    end
  end  
end
