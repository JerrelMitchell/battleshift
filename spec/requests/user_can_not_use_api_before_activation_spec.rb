require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'they should not be able to use API key prior to account activation' do
    user = User.create!(name: "Mulder", email: "fox@x.com", password: "123", status: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/api/v1/games"

    returned = JSON.parse(response.body)
    expect(returned["error"]).to eq("Account has not yet been activated.")
  end
end
