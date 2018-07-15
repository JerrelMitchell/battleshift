require 'rails_helper'

RSpec.describe Turn do
  let(:game) {
    Game.create!(player_1_board: Board.new(4),
                 player_2_board: Board.new(4),
                 player_1_turns: 0,
                 player_2_turns: 0,
                 current_turn: "challenger")
  }

  let(:user) {
    User.create!(name: 'Sally Test',
                 email: 'sally@example.com',
                 password: 'sallyspassword',
                 status: 1)
  }

  let(:payload) {
    { ship_size: 3, start_space: 'A1', end_space: 'A3' }
  }

  let(:turn) { Turn.new(game, user, payload) }
  describe 'Attributes' do
    it 'should have a game attribute' do
      expect(turn.current_game).to eq(game)
    end

    it 'should have a current_player attribute' do
      expect(turn.current_player).to eq(user)
    end

    it 'should have a payload attribute' do
      expect(turn.payload).to eq(payload)
    end
  end
end
