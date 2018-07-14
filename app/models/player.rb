class Player < SimpleDelegator
  attr_reader :board, :ships

  def initialize(board, user = nil)
    @user = user
    @board = board
    @ships = {
      destroyers: 1,
      cruisers: 1
    }
  end

  def decrease_ship_count(ship_length)
    @ships[:destroyers] -= 1 if ship_length == 3
    @ships[:cruisers] -= 1 if ship_length == 2
  end
end
