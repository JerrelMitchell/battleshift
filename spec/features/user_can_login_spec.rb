require 'rails_helper'

RSpec.describe 'Session / Login Functionality' do
  it 'they should be able to log in' do
    visit '/login'

    user = User.create!(name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content("Logged in as #{user.name}")
    # expect(page).to have_content('Status: Active')
  end

  it 'they should be able to not log in with incorrect credentials' do
    visit '/login'

    user = User.create!(name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "abc123"
    click_button 'Login'

    expect(page).to have_current_path('/login')
    expect(page).to have_content("Invalid email and/or password.")
  end
end
