class Turn
  attr_reader :current_game, :current_player, :payload

  def initialize(current_game, current_user, payload)
    @current_game   = current_game
    @current_player = current_user
    @payload        = JSON.parse(payload)
  end

  def current_board
    if @current_game.current_turn == 'challenger'
      @current_game.player_1_board
    elsif @current_game.current_turn == 'opponent'
      @current_game.player_2_board
    end
  end

  def current_ship
    @current_ship ||= Ship.new(@payload['ship_size'])
  end

  def place_ship
    # Make the ship placer and run it
    ShipPlacer.new(board: current_board, 
                   ship: current_ship, 
                   start_space: @payload['start_space'], 
                   end_space: @payload['end_space']).run
  end

  def update_board_with_ship
    if @current_game.current_turn == 'challenger'
      @current_game.update!(player_1_board: current_board)
    elsif @current_game.current_turn == 'opponent'
      @current_game.update!(player_1_board: current_board)
    end
  end

  def update_player_ship_count
    if current_ship.type == 'destroyer' && @current_game.current_turn == 'challenger'
      @current_game.update!(player_1_board: @current_game.player_1_destroyer_count - 1)
    elsif current_ship.type == 'cruiser' && @current_game.current_turn == 'challenger'
      @current_game.update!(player_1_board: @current_game.player_1_cruiser_count - 1)
    elsif current_ship.type == 'destroyer' && @current_game.current_turn == 'opponent'
      @current_game.update!(player_2_board: @current_game.player_2_destroyer_count - 1)
    elsif @current_ship.type == 'cruiser' && @current_game.current_turn == 'opponent'
      @current_game.update!(player_2_board: @current_game.player_2_cruiser_count - 1)
    end
  end

  # def current_player
  #   @current_player ||= Player.new(@current_user, )
  # end
end
