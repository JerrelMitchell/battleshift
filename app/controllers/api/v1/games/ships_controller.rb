class Api::V1::Games::ShipsController < Api::V1::ApplicationController
  def create
    game    = Game.find(params[:game_id])
    user    = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    player  = Player.new(nil,user)
    # require 'pry';binding.pry
    payload = JSON.parse(request.body.string)
    ship    = Ship.new(payload['ship_size'])
    board   = UserGame.choose_board(user, game)
    placer  = ShipPlacer.new(board: board,
                             ship: ship,
                             start_space: payload['start_space'],
                             end_space: payload['end_space'])

    placer.run

    game.update(player_1_board: game.player_1_board, player_2_board: game.player_2_board)
    player.decrease_ship_count(:destroyers)

    render json: game, message: GameMessagesService.new(player, payload: payload).ship_placement_feedback
  end
end
