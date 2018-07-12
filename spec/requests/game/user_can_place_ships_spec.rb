require 'rails_helper'

RSpec.describe 'User Ship Placement Request' do
  it 'they should be able to place ships' do
    email1  = 'catherinezetajones@threatlevel.com'
    player1 = User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt')
    player2 = User.create!(name: 'Golden Face', email: email1, password: 'midnight')
    headers = { 'CONTENT_TYPE' => 'application/json', 'X-API-KEY' => player1.auth_token }
    email2  = { opponent_email: player2[:email] }.to_json

    post '/api/v1/games', params: email2, headers: headers
    payload = { ship_size: 3, start_space: 'A1', end_space: 'A3' }.to_json

    headers = { 'X-Api-Key' => player1.auth_token, 'CONTENT_TYPE' => 'application/json' }
    params = { body: payload }.to_json

    post "/api/v1/games/#{Game.last.id}/ships", params: params, headers: headers

    game_board = Game.last.player_1_board.board.first

    expect(game_board.first['A1']).to_not eq(nil)
    expect(game_board[2]['A3']).to_not eq(nil)
    expect(game_board.last['A6'].contents).to eq(nil)
  end

  it 'should not allow players to place a ship who are not a part of this game' do

  end
end