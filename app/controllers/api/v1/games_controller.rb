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
      end
    end
  end
end
