require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'they should not be able to use API key prior to account activation' do
    user = User.create!(name: "Mulder", email: "fox@x.com", password: "123", status: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "api/v1/games/new"

    expect(current_page).to have_content("Account has not yet been activated.")
  end
end
