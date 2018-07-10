require 'rails_helper'

RSpec.describe 'Activation' do
  it 'they should be able to activate their account' do
    inactive_user = User.create!(name: 'Sally', email: 'sally@example.com', password: 'sallyspassword', status: 0)

    expect(inactive_user.status).to eq('inactive')

    get "/activate/#{inactive_user.id}"

    expect(User.find(inactive_user.id).status).to eq('active')
    # expect(page).to have_content('You\'ve successfully activated your account!')
  end
end
