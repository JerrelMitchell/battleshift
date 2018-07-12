class Api::V1::GamesController < ActionController::API
  def show
    if Game.exists?(id: params[:id])
      game = Game.find(params[:id])
      render json: game
    else
      render status: 400
    end
  end

  def create
    player_1 = User.find_by(auth_token: request.headers["HTTP_X_API_KEY"])
    player_2 = User.find_by(email: params[:opponent_email])

    game = Game.create!(
      player_1_board: Board.new(6),
      player_2_board: Board.new(6),
      player_1_turns: 0,
      player_2_turns: 0,
      current_turn: 'challenger'
    )

    game.user_games.create!(user_id: player_1.id, player: 0)
    game.user_games.create!(user_id: player_2.id, player: 1)
  end
end
