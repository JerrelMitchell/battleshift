class Api::V1::Games::ShipsController < Api::V1::ApplicationController
  def create
    # find game, user, and payload
    # game    = Game.find(params[:game_id])
    # user    = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    # payload = JSON.parse(request.body.string)
    # Set game state with game user, and payload
    # game = Game.find(params[:game_id])
    # game.set_state( User.find_by(auth_token: request.headers['HTTP_X_API_KEY']),
    #                 JSON.parse(request.body.string))
    turn = Turn.new(Game.find(params[:game_id]),
                    User.find_by(auth_token: request.headers['HTTP_X_API_KEY']),
                    request.body.string)
    # determine ship and player, create meta
    # Use game.current_ship instead
    # ship = game.new_ship(payload['ship_size'])

    # player_number = UserGame.find_by(game: game, user: user).player 
    # player_ship = "#{player_number}_#{ship.type}_count"
    # board = game["#{player_number}_board"]
    # place ship
    # ShipPlacer.new(board: board, ship: ship, start_space: payload['start_space'], end_space: payload['end_space']).run

    # This should be an instance method called update_board (game)
    # if player_number == 'player_1'
    #   game.update(player_1_board: board)
    # elsif player_number == 'player_2'
    #   game.update(player_1_board: board)
    # end

    # update appropriate ship count on game record
    # This should be another instance method called update_ship_count (game)
    # if player_number == 'player_1'
    #   if ship.type == 'destroyer'
    #     game.update!(player_1_destroyer_count: game.player_1_destroyer_count - 1)
    #   elsif ship.type == 'cruiser'
    #     game.update!(player_1_cruiser_count: game.player_1_cruiser_count - 1)
    #   end
    # elsif player_number == 'player_2'
    #   if ship.type == 'destroyer'
    #     game.update!(player_2_destroyer_count: game.player_2_destroyer_count - 1)
    #   elsif ship.type == 'cruiser'
    #     game.update!(player_2_cruiser_count: game.player_2_cruiser_count - 1)
    #   end
    # end

    # updated_game = Game.find(params[:game_id])

    # render json for game and message
    render json: turn.current_game, message: GameMessagesService.new(game: turn.current_game, ship: turn.current_ship).ship_placement_feedback
  end
end
