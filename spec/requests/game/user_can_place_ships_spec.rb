require 'rails_helper'

RSpec.describe 'User Ship Placement Request' do
  it 'they should be able to place ships' do
    let(:player_1) { User.create!(name: 'Michael Scarn', email: 'goldenfacehunter@scarn.com', password: 'dwigt') }
    let(:player_2) { User.create!(name: 'Golden Face', email: 'catherinezetajones@threatlevel.com', password: 'midnight') }
    let(:game_attributes) { Hash.new(player_1_board: Board.new(4),
                                     player_2_board: Board.new(4),
                                     player_1_turns: 0,
                                     player_2_turns: 0,
                                     current_turn: 'challenger') 
                          }
    let(:game) { Game.create!(game_attributes) }

  end
end
