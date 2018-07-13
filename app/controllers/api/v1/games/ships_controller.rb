class Api::V1::Games::ShipsController < ApplicationController
  def create
    game    = Game.find(params[:game_id])
    player  = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    payload = JSON.parse(params[:body])
    ship    = Ship.new(payload['ship_size'])
    board   = UserGame.create_board(player, game)
    placer  = ShipPlacer.new(board: board,
                             ship: ship,
                             start_space: payload['start_space'],
                             end_space: payload['end_space'])

    placer.run
    Game.find(game.id).update(player_1_board: game.player_1_board, player_2_board: game.player_2_board).render_json
  end
end
