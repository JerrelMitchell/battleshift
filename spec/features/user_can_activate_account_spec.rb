require 'rails_helper'

RSpec.describe 'Account Activation' do
  it "sends an email to a newly registered account where user can activate their account" do
    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }
    email_link = /Welcome to Battleshift. Activate your account here!/

    visit '/register'

    fill_in 'Email', with: user[:email]
    fill_in 'Name', with: user[:name]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Submit'

    email = ActionMailer::Base.deliveries.last

    expect(email.from).to eq(['no-reply@example.com'])
    expect(email.to).to eq([user[:email]])
    expect(email.subject).to eq('Welcome to Battleshift. Activate your account here!')
    expect(email.html_part.body).to match(email_link)
    expect(email.html_part.body).to match(User.last.key)
  end
  it 'should take user to confirmation page after activating account' do
    active_user = User.create!(name: 'Sally', email: 'sally@example.com', password: 'sallyspassword', status: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(active_user)

    visit '/confirmation'

    expect(page).to have_content('You\'ve successfully activated your account!')
    expect(page).to have_link('Dashboard')

    visit '/dashboard'

    expect(page).to have_content('Status: Active')
  end
end
