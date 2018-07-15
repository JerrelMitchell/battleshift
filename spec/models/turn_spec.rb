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

  let(:user2) {
    User.create!(name: 'Calvin Test',
                 email: 'calvin@example.com',
                 password: 'calvinspassword',
                 status: 1)
  }

  let(:payload) {
    { ship_size: 3, start_space: 'A1', end_space: 'A3' }.to_json
  }

  before :each do
    game.user_games.create!(user_id: user.id, player: 0)
    game.user_games.create!(user_id: user2.id, player: 1)
  end

  let(:turn) { Turn.new(game, user, payload) }
  describe 'Attributes' do
    it 'should have a game attribute' do
      expect(turn.current_game).to eq(game)
    end

    it 'should have a current_player attribute' do
      expect(turn.current_player).to eq(user)
    end

    it 'should have a payload attribute' do
      expect(turn.payload).to eq(JSON.parse(payload))
    end
  end

  context 'Instance Methods' do
    describe '#current_board' do
      it 'should return the current board object based on the current_player' do
        expect(turn.current_board).to eq(game.player_1_board)

        turn2 = Turn.new(game, user2, payload)
        expect(turn2.current_board).to eq(game.player_2_board)
      end
    end

    describe '#current_ship' do
      it 'should return a ship object as the current_ship based on payload\'s ship size' do
        expect(turn.current_ship).to be_a(Ship)
        expect(turn.current_ship.length).to eq(3)
        expect(turn.current_ship.type).to eq('destroyer')
      end
    end

    describe '#place_ship' do
      it 'should place the ship based on current turn attributes' do
        turn.place_ship
        first_row = turn.current_board.board.first

        expect(first_row[0]['A1'].contents).to be_a(Ship)
        expect(first_row[1]['A2'].contents).to be_a(Ship)
        expect(first_row[2]['A3'].contents).to be_a(Ship)
        expect(first_row[3]['A4'].contents).to eq(nil)
      end
    end

    describe '#update_board_with_ship' do
      it 'should update the database record to account for the newly placed ship' do
        turn.update_board_with_ship
        
      end
    end
  end
end
