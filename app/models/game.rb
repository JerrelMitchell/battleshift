class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  has_many :user_games
  has_many :users, through: :user_games

  # POROesque hybridization
  # attr_reader :current_player, :payload

  # def set_state(current_user, payload)
  #   @current_player = current_user
  #   @payload = payload
  # end

  # def current_ship
  #   @current_ship ||= Ship.new(@payload['ship_size'])
  # end
end
