require 'rails_helper'

describe 'GET /api/v1/games' do
  context 'user starts game' do
    it 'return successful post response' do
      email = 'catherinezetajones@threatlevel.com'
      player_1 = User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt')
      player_2 = User.create!(name: 'Golden Face', email: email, password: 'midnight')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(player_1)

      post "/api/v1/games?api_key=#{player_1.auth_token}&opponent_email=#{email}"

      expect(response).to be_successful
      expect(Game.last.users).to eq([player_1, player_2])
    end
  end
end
