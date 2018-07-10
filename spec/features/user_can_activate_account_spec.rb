require 'rails_helper'

RSpec.describe 'Account Activation' do
  it "sends an email to a newly registered account where user can activate their account" do
    activation_link = 'Visit here to activate your account.'
    thanks_message = 'Thank you! Your account is now activated.'
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
  end

  it 'should take user to confirmation page after activating account' do
    inactive_user = User.create(email: 'sally@example.com', name: 'Sally Test', password: 'sallyspassword', status: 0)

    expect(inactive_user.status).to eq('inactive')
    
    visit "/activate/#{inactive_user.id}"

    expect(inactive_user.status).to eq('active')
    expect(page).to have_content('You\'ve successfully activated your account!')

  end
end
