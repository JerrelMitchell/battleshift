require 'rails_helper'

RSpec.describe 'User Ship Placement Request' do
  let(:player1) { User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt') }
  let(:player2) { User.create!(name: 'Golden Face', email: 'catherinezetajones@threatlevel.com', password: 'midnight') }
  it 'they should be able to place ships and receive feedback about remaining ships' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'X-API-KEY' => player1.auth_token }
    post '/api/v1/games', params: { opponent_email: player2[:email] }.to_json, headers: headers
    
    payload = { ship_size: 3, start_space: 'A1', end_space: 'A3' }
    headers = { 'X-Api-Key' => player1.auth_token, 'CONTENT_TYPE' => 'application/json' }
    
    post "/api/v1/games/#{Game.last.id}/ships", params: payload.to_json, headers: headers
    
    game_board_rows = Game.last.player_1_board.board
    first_row        = game_board_rows.first

    expect(first_row[0]['A1'].contents).to be_a(Ship)
    expect(first_row[1]['A2'].contents).to be_a(Ship)
    expect(first_row[2]['A3'].contents).to be_a(Ship)
    expect(first_row[3]['A4'].contents).to eq(nil)

    response_data = JSON.parse(response.body)

    expect(response_data["message"]).to eq("Successfully placed ship with a size of #{payload[:ship_size]}. You have 1 ship(s) to place with a size of 2.")

    new_payload = { ship_size: 2, start_space: 'B1', end_space: 'B2' }
    # Utilizes same headers from above
    post "/api/v1/games/#{Game.last.id}/ships", params: new_payload.to_json, headers: headers

    new_game_board_rows = Game.last.player_1_board.board
    second_row = new_game_board_rows[1]

    expect(second_row[0]['B1'].contents).to be_a(Ship)
    expect(second_row[1]['B2'].contents).to be_a(Ship)
    expect(second_row[2]['B3'].contents).to eq(nil)
    expect(second_row[3]['B4'].contents).to eq(nil)

    new_response_data = JSON.parse(response.body)

    expect(new_response_data['message']).to eq("Successfully placed ship with a size of #{new_payload[:ship_size]}. You have 0 ship(s) to place.")

  end

  xit 'should not allow players to place a ship who are not a part of this game' do

  end
end
