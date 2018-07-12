require 'rails_helper'

RSpec.describe 'User Ship Placement Request' do
  # let(:player_1) { User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt') }
  # let(:player_2) { User.create!(name: 'Golden Face', email: 'catherinezetajones@threatlevel.com', password: 'midnight') }
  # let(:mean_player) { User.create!(name: 'Harold Saxon', email: 'hsaxon@gallifrey.com', password: 'thedrums') }

  # let(:game) { Game.create!(player_1_board: Board.new(4),
  #                           player_2_board: Board.new(4),
  #                           player_1_turns: 0,
  #                           player_2_turns: 0,
  #                           current_turn: 'challenger')
  #            }

  it 'they should be able to place ships' do
    email = 'catherinezetajones@threatlevel.com'
    player_1 = User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt')
    player_2 = User.create!(name: 'Golden Face', email: email, password: 'midnight')

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.auth_token }
    email = {opponent_email: player_2[:email]}.to_json

    post "/api/v1/games", params: email, headers: headers
    payload = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
    }.to_json

    headers = {'X-Api-Key' => player_1.auth_token, 'CONTENT_TYPE' => 'application/json'}
    params = { body: payload }.to_json
    post "/api/v1/games/#{Game.last.id}/ships", params: params, headers: headers
  end

  it 'should not allow players to place a ship who are not a part of this game' do

  end
end
