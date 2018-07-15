class Ship
  attr_reader :length,
              :damage,
              :start_space,
              :end_space

  def initialize(length)
    @length = length
    @damage = 0
    @start_space = nil
    @end_space = nil
  end

  def place(start_space, end_space)
    @start_space = start_space
    @end_space = end_space
  end

  def attack!
    @damage += 1
  end

  def type
    return 'destroyer' if @length == 3
    return 'cruiser' if @length == 2
    return 'unknown'
  end

  def is_sunk?
    @damage == @length
  end
end
