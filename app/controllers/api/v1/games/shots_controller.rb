class Api::V1::Games::ShotsController < Api::V1::ApplicationController
  def create
    game = Game.find(params[:game_id])
    turn_processor = TurnProcessor.new(game, params[:shot][:target], User.find_by(auth_token: request.headers['HTTP_X_API_KEY']))
    # require 'pry';binding.pry
    if turn_processor.is_players_turn?
      turn_processor.run!
      render json: game, message: turn_processor.message
    else
      render json: game, status: 400, message: GameMessagesService.new.not_your_turn 
    end
  end
end
