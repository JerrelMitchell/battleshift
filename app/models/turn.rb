class Turn
  attr_reader :current_game, :current_player, :payload

  def initialize(current_game, current_user, payload)
    @current_game   = current_game
    @current_player = current_user
    @payload        = payload
  end

  def current_board
    if @current_game.current_turn == 'challenger'
      @current_game.player_1_board
    elsif @current_game.current_turn == 'opponent'
      @current_game.player_2_board
    end
  end

  # def current_player
  #   @current_player ||= Player.new(@current_user, )
  # end
end
