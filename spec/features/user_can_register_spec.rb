require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'they should be able to reach the registration page' do
    visit '/'

    click_link 'Register'

    expect(page).to have_current_path('/register')
  end
  it 'they should be able to register' do
    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }

    visit '/register'

    fill_in 'Email', with: user[:email]
    fill_in 'Name', with: user[:name]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Submit'

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content("Logged in as #{user[:name]}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
  it 'they should get error message if name field missing' do
    visit '/register'

    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }

    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Submit'

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Please make sure all fields are complete")
  end
  it 'they should get error message if email field missing' do
    visit '/register'

    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }

    fill_in 'Name', with: user[:name]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Submit'

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Please make sure all fields are complete")
  end
  it 'they should get error message if password confirmation field missing' do
    visit '/register'

    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }

    fill_in 'Email', with: user[:email]
    fill_in 'Name', with: user[:name]
    fill_in 'Password', with: user[:password]
    click_button 'Submit'

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Please make sure all fields are complete")
  end
end
