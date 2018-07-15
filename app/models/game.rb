class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  has_many :user_games
  has_many :users, through: :user_games

  def new_ship(ship_length)
    Ship.new(ship_length)
  end
end
