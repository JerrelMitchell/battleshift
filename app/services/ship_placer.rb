class ShipPlacer
  def initialize(board:, ship:, start_space:, end_space:)
    @board       = board
    @ship        = ship
    @start_space = start_space
    @end_space   = end_space
  end

  def run
    if same_row?
      place_in(start_space[0], start_space[1]..end_space[1], 'horizontal')
    elsif same_column?
      place_in(start_space[1], start_space[0]..end_space[0], 'verticle')
    else
      raise(ShipPlacementError.new.crooked!)
    end
  end

  private

  attr_reader :board, :ship, :start_space, :end_space

  def same_row?
    start_space[0] == end_space[0]
  end

  def same_column?
    start_space[1] == end_space[1]
  end

  def place_in(start_space, range, orientation)
    raise ShipPlacementError.new.length_error! unless range.count == ship.length
    range.each { |column| place_ship(start_space, column) } if orientation == 'horizontal'
    range.each { |row| place_ship(row, start_space) }       if orientation == 'verticle'
  end

  def place_ship(row, column)
    coordinates = "#{row}#{column}"
    space = board.locate_space(coordinates)
    raise ShipPlacementError.new.space_occupied! if space.occupied?
    space.occupy!(ship)
  end
end
