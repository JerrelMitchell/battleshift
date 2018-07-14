class Player
  attr_reader :board, :ships

  def initialize(board)
    @board = board
    @ships = {
      destroyers: 1,
      cruisers: 1
    }
  end

  def decrease_ship_count(ship_type)
    @ships[ship_type] -= 1
  end
end
