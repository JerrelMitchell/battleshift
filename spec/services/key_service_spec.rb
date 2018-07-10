require 'rails_helper'

describe KeyService do
  it 'should be able to generate an API key' do
    user = User.create!(name: 'Sally', email: 'sally@example.com', password: 'sallyspassword')
    key_service = KeyService.new(user)

    api_key = key_service.create_key

    expect(User.find(user.id).key).to eq(api_key)
  end
end
