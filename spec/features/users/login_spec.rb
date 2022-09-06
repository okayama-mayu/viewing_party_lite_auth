require 'rails_helper' 

RSpec.describe 'Logging In' do 
  # As a registered user
    # When I visit the landing page `/`
    # I see a link for "Log In"
    # When I click on "Log In"
    # I'm taken to a Log In page ('/login') 
    # where I can input my unique email and password.
    # When I enter my unique email and correct password 
    # I'm taken to my dashboard page
  end
  it 'can log in with valid credentials' do 
    user = User.create!(name: 'Carlos Stich', email: 'c@gmail.com', password: 'abcdefg')

    visit root_path 

    click_link 'Log In' 

    expect(current_path).to eq login_path

    fill_in :email, with: user.email 
    fill_in :password, with: user.password

    click_on 'Log In' 

    expect(current_path).to eq(user_route(user))
  end
end