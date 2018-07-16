class Api::V1::Games::ShotsController < Api::V1::ApplicationController
  def create
    game = Game.find(params[:game_id])
    turn_processor = TurnProcessor.new(game, params[:shot][:target], User.find_by(auth_token: request.headers['HTTP_X_API_KEY']))

    if !turn_processor.is_players_turn?
      render json: game, status: 400, message: GameMessagesService.new.not_your_turn
    elsif !turn_processor.valid_coordinates?
      render json: game, status: 400, message: GameMessagesService.new.invalid_coordinates
    else
      result = turn_processor.run!
      if turn_processor.game_over?
        render json: game, message: "Your shot resulted in a Hit. Battleship sunk. Game over."
      elsif result == 'Hit'
        render json: game, message: "Your shot resulted in a Hit. Battleship sunk."
      elsif result == 'Miss'
        render json: game, message: "Your shot resulted in a Miss."
      end
    end
  end
end
