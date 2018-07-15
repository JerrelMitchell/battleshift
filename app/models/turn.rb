class Turn
  attr_reader :current_game, :current_player, :payload

  def initialize(current_game, current_user, payload)
    @current_game   = current_game
    @current_player = current_user
    @payload        = payload
  end

  def current_board

  end
end
