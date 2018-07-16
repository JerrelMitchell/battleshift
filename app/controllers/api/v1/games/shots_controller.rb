class Api::V1::Games::ShotsController < Api::V1::ApplicationController
  def create
    game = Game.find(params[:game_id])
    turn_processor = TurnProcessor.new(game, params[:shot][:target], User.find_by(auth_token: request.headers['HTTP_X_API_KEY']))

    if !turn_processor.is_players_turn?
      render json: game, status: 400, message: GameMessagesService.new.not_your_turn
    elsif !turn_processor.valid_coordinates?
      render json: game, status: 400, message: GameMessagesService.new.invalid_coordinates
    elsif game.winner
      render json: game, status: 400, message: GameMessagesService.new.game_over
    else
      turn_processor.run!
      render json: game, message: turn_processor.message
    end
  end
end
