require 'rails_helper'

describe 'GET /api/v1/games' do
  context 'user starts game' do
    it 'return successful post response' do
      email = 'catherinezetajones@threatlevel.com'
      player_1 = User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt')
      player_2 = User.create!(name: 'Golden Face', email: email, password: 'midnight')

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_2.auth_token }
      email = {opponent_email: player_2[:email]}.to_json

      post "/api/v1/games", params: email, headers: headers
      expect(response).to be_successful
#Need to associate users with game before passing this part of the test 
      expect(Game.last.users).to eq([player_1, player_2])
    end
  end
end
