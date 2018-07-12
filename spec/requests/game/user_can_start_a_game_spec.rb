require 'rails_helper'

describe 'GET /api/v1/games' do
  context 'user starts game' do
    it 'return successful post response' do
      email1  = 'catherinezetajones@threatlevel.com'
      player1 = User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt')
      player2 = User.create!(name: 'Golden Face', email: email1, password: 'midnight')
      headers = { 'CONTENT_TYPE' => 'application/json', 'X-API-KEY' => player1.auth_token }
      email2  = { opponent_email: player2[:email] }.to_json

      post '/api/v1/games', params: email2, headers: headers

      expect(response).to be_successful
      expect(Game.last.users).to eq([player1, player2])
    end
  end
end
