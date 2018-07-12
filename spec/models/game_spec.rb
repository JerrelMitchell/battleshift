require 'rails_helper'

RSpec.describe Game, type: :model do
  it "should have player boards" do
    turn = "challenger"
    player_1_board = Board.new(4)
    player_2_board = Board.new(4)
    game_attributes = {
                    player_1_board: player_1_board,
                    player_2_board: player_2_board,
                    player_1_turns: 0,
                    player_2_turns: 0,
                    current_turn: turn
                  }

    game = Game.create!(game_attributes)

    expect(game.player_1_board.length).to eq(4)
    expect(game.player_2_board.length).to eq(4)
    expect(game.player_1_turns).to eq(0)
    expect(game.player_2_turns).to eq(0)
    expect(game.current_turn).to eq(turn)
  end

  describe 'Relationships' do
    it { should have_many(:user_games) }
    it { should have_many(:users).through(:user_games) }
  end
end
