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
      # result = attack_opponent
      # ai_attack_back
      update_current_turn
      # if result == 'Hit'
      #   ship_sunk?
      # end

      # # if result == 'Hit' && ship_sunk?
      # #   @messages << "Battleship sunk."
      # # end

      # # if opponent_game_data.player_ships == 0
      # #   # require 'pry';binding.pry
      # #   @messages << "Game over."
      # # end

      game.save!
    rescue GameError => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  def is_players_turn?
    return true if player_number == 'player_1' && game.current_turn == 'challenger'
    return true if player_number == 'player_2' && game.current_turn == 'opponent'
    return false
  end

  def valid_coordinates?
    opponent.board.space_names.include?(@target)
  end

  def game_over?
    player_game_data.player_ships == 0 || opponent_game_data.player_ships == 0
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result}."

    if result == 'Hit' && ship_sunk?
      @messages << "Battleship sunk."
    end

    if result == 'Hit' && opponent_game_data.player_ships == 0
      @messages << "Game over."
    end

    add_to_player_turn
    result
  end

  def ship_sunk?
    ship = opponent.board.locate_space(target).contents
    if ship.is_sunk?
      sink_ship
    end
  end

  def sink_ship
    new_ship_count = opponent_game_data.player_ships -= 1
    opponent_game_data.update!(player_ships: new_ship_count)
  end

  # def game_over?
  #   player_game_data.player_ships == 0 || opponent_game_data.player_ships == 0
  # end

  def update_current_turn
    if game.current_turn == 'challenger'
      game.current_turn = 'opponent'
    elsif game.current_turn == 'opponent'
      game.current_turn = 'challenger'
    end
  end

  def add_to_player_turn
    game.player_1_turns += 1 if player_number == 'player_1'
    game.player_2_turns += 1 if player_number == 'player_2'
  end

  # def ai_attack_back
  #   result = AiSpaceSelector.new(player.board).fire!
  #   @messages << "The computer's shot resulted in a #{result}."
  #   game.player_2_turns += 1
  # end

  def player_game_data
    UserGame.find_by(game: game, user: @player)
  end

  def opponent_game_data
    return UserGame.find_by(game: game, player: 'player_2') if player_number == 'player_1'
    return UserGame.find_by(game: game, player: 'player_1') if player_number == 'player_2'
  end

  def player_number
    UserGame.find_by(game: @game, user: @player).player
  end

  def current_player_board
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
