class GameError < StandardError

  def initialize(msg = "Invalid attack.")
    super(msg)
  end

  def crooked!
    'Ship must be in either the same row or column.'
  end

  def length_error!
    'Ship size must be equal to the number of spaces you are trying to fill.'
  end

  def space_occupied!
    'Attempting to place ship in a space that is already occupied.'
  end
end
