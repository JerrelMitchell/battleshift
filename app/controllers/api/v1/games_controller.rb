module Api
  module V1
    class GamesController < ActionController::API
      def show
        if Game.exists?(id: params[:id])
          game = Game.find(params[:id])
          render json: game
        else
          render status: 400
        end
      end

      def create
        Game.create!(
          player_1_board: Board.new(6),
          player_2_board: Board.new(6),
          player_1_turns: 0,
          player_2_turns: 0,
          current_turn: 'challenger'
        )
      end
    end
  end
end
