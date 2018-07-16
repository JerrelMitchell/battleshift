class Player
  attr_reader :board, :ships_to_place

  def initialize(board, user = nil)
    @user = user
    @board = board
    @ships_to_place = {
      destroyers: 1,
      cruisers: 1
    }
  end

  def decrease_ship_count(ship_length)
    @ships_to_place[:destroyers] -= 1 if ship_length == 3
    @ships_to_place[:cruisers] -= 1 if ship_length == 2
  end
end
