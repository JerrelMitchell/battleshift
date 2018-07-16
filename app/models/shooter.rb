class Shooter
  def initialize(board:, target:)
    @board     = board
    @target    = target
    @message   = ""
  end

  def fire!
    if valid_shot?
      space.attack!
    else
      raise GameError.new("Invalid coordinates.")
    end
  end

  def self.fire!(board:, target:)
    new(board: board, target: target).fire!
  end

  def valid_shot?
    board.space_names.include?(target)
  end

  private
    attr_reader :board, :target

    def space
      @space ||= board.locate_space(target)
    end
end
