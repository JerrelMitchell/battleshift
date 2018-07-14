class Player
  attr_reader :board, :ships

  def initialize(board)
    @board = board
    @ships = {
      destroyers: 1,
      cruisers: 1
    }
  end
end
