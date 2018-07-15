class UserGame < ApplicationRecord
  validates_presence_of :player

  belongs_to :user
  belongs_to :game

  enum player: ['player_1', 'player_2']

  def self.choose_board(user, game)
    if find_by(user_id: user.id).player == 'player_1'
      board = game.player_1_board
    else
      board = game.player_2_board
    end
    board
  end
end
