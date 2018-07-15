class Api::V1::Games::ShipsController < Api::V1::ApplicationController
  def create
    turn = Turn.new(Game.find(params[:game_id]),
                    User.find_by(auth_token: request.headers['HTTP_X_API_KEY']),
                    request.body.string)

    turn.place_ship
    message_service = GameMessagesService.new(game: turn.current_game, ship: turn.current_ship)
    render json: turn.current_game, message: message_service.ship_placement_feedback
  end
end
