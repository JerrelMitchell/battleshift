class Api::V1::Games::ShipsController < ApplicationController
  def create
    # Find the game using the game_id in params
    game = Game.find(params[:game_id])

    # Find player using auth_token
    player = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    payload = JSON.parse(params[:body])

    
    # Create a new Ship object with length from request body param
    ship = Ship.new(payload['ship_size'])

    # Create ShipPlacer object with game.player_#_board, ship, 
    #   start_space (from req body param), end_space (from req body param)

    # !!!!!!
    # Don't hard code player 1's board, game needs player 1 and player 2 fields
    # !!!!!!
    placer = ShipPlacer.new(game.player_1_board, ship, payload['start_space'], payload['end_space'])

    # Run ShipPlacer
    placer.run
  end
end
