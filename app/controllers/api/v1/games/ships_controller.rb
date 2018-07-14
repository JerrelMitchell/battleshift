class Api::V1::Games::ShipsController < Api::V1::ApplicationController
  def create
    game    = Game.find(params[:game_id])
    player  = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    payload = JSON.parse(request.body.string)
    ship    = Ship.new(payload['ship_size'])
    board   = UserGame.create_board(player, game)
    placer  = ShipPlacer.new(board: board,
                             ship: ship,
                             start_space: payload['start_space'],
                             end_space: payload['end_space'])

    placer.run

    game.update(player_1_board: game.player_1_board, player_2_board: game.player_2_board)
binding.pry
    render json:game, message: "Successfully placed ship with a size of #{payload['ship_size']}. You have #{} ship(s) to place with a size of 2."
  end
end
