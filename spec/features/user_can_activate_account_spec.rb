require 'rails_helper'

RSpec.describe 'Account Activation' do
  it "sends an email to a newly registered account where user can activate their account" do
    last_email = ActionMailer::Base.deliveries.last
    activation_link = 'Visit here to activate your account.'
    thanks_message = 'Thank you! Your account is now activated.'
    user = { name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword' }

    visit '/register'

    fill_in 'Email', with: user[:email]
    fill_in 'Name', with: user[:name]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Submit'

    expect(last_email.body.raw_source).to have_link(activation_link)
    click_link activation_link
    expect(page).to have_current_path('/confirmation')
    expect(page).to have_content(thanks_message)

    visit '/dashboard'
    expect(page).to have_content('Status: Active')
  end
end
