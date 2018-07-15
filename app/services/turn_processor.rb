class TurnProcessor
  def initialize(game, target, player)
    @game   = game
    @target = target
    @messages = []
    @player = player
  end

  def run!
    begin
      attack_opponent
      # ai_attack_back
      game.save!
    rescue GameError => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
  end

  # def ai_attack_back
  #   result = AiSpaceSelector.new(player.board).fire!
  #   @messages << "The computer's shot resulted in a #{result}."
  #   game.player_2_turns += 1
  # end

  def player_number
    UserGame.find_by(game: @game, user: @player).player
  end

  def current_player_board
    # require 'pry';binding.pry
    if player_number == 'player_1'
      game.player_1_board
    elsif player_number == 'player_2'
      game.player_2_board
    end
  end

  def current_opponent_board
    if player_number == 'player_1'
      game.player_2_board
    elsif player_number == 'player_2'
      game.player_1_board
    end
  end

  def player
    Player.new(current_player_board)
  end

  def opponent
    Player.new(current_opponent_board)
  end
end
