require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:player_type) { "challenger" }
  let(:game) {
    Game.create!( player_1_board: Board.new(4),
                  player_2_board: Board.new(4),
                  player_1_turns: 0,
                  player_2_turns: 0,
                  current_turn: player_type)
  }

  it "should have player boards" do
    expect(game.player_1_board.length).to eq(4)
    expect(game.player_2_board.length).to eq(4)
    expect(game.player_1_turns).to eq(0)
    expect(game.player_2_turns).to eq(0)
    expect(game.current_turn).to eq(player_type)
    expect(game.player_1_destroyer_count).to eq(1)
    expect(game.player_1_cruiser_count).to eq(1)
    expect(game.player_2_destroyer_count).to eq(1)
    expect(game.player_2_cruiser_count).to eq(1)
  end

  describe 'Relationships' do
    it { should have_many(:user_games) }
    it { should have_many(:users).through(:user_games) }
  end

  context 'Instance Methods' do
    describe '#new_ship' do
      it 'should instantiate a new ship object' do
        # Create a destroyer
        ship_length = 3
        ship = game.new_ship(ship_length)

        expect(ship).to be_a(Ship)
        expect(ship.length).to eq(3)
        expect(ship.type).to eq('destroyer')

        # Create a cruiser
        ship_length = 2
        ship = game.new_ship(ship_length)

        expect(ship).to be_a(Ship)
        expect(ship.length).to eq(2)
        expect(ship.type).to eq('cruiser')
      end
    end
  end
end
