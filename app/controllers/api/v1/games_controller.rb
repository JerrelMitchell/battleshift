module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find(params[:id])
        render json: game
      end

      def create
        render json: { error: "Account has not yet been activated." }
      end
    end
  end
end
