class Api::V1::Games::ShipsController < Api::V1::ApplicationController
  def create
    # game          = Game.find(params[:game_id])
    # user          = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
    # payload       = JSON.parse(request.body.string)
    # ship          = Ship.new(payload['ship_size'])
    # require 'pry';binding.pry
    # player_number = UserGame.where(game: game, user: user).first.player
    # ship_counter  = "#{player_number}_#{ship.type}_count"
    # if ship_counter == 'player_1_cruiser_cruiser'  game.update(player_1_destroyer_count: )
    # board         = UserGame.choose_board(user, game)
    # placer        = ShipPlacer.new(board: board,
    #                          ship: ship,
    #                          start_space: payload['start_space'],
    #                          end_space: payload['end_space'])

    # placer.run

    # game.update(player_1_board: game.player_1_board, player_2_board: game.player_2_board)
    
    
    # render json: game, message: GameMessagesService.new(user, payload: payload).ship_placement_feedback
    #  ============

    # find game
    game = Game.find(params[:game_id])

    # find user
    user = User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])

    # Gather payload

    payload       = JSON.parse(request.body.string)

    # determine ship and player, create meta
    ship = Ship.new(payload['ship_size'])
    player_number = UserGame.find_by(game: game, user: user).player 
    player_ship = "#{player_number}_#{ship.type}_count"
    board = game["#{player_number}_board"]
    # place ship
    ShipPlacer.new(board: board, ship: ship, start_space: payload['start_space'], end_space: payload['end_space']).run

    # This should be an instance method called update_board (game)
    if player_number == 'player_1'
      game.update(player_1_board: board)
    elsif player_number == 'player_2'
      game.update(player_1_board: board)
    end

    # update appropriate ship count on game record
    # This should be another instance method called update_ship_count (game)
    if player_number == 'player_1'
      if ship.type == 'destroyer'
        game.update!(player_1_destroyer_count: game.player_1_destroyer_count - 1)
      elsif ship.type == 'cruiser'
        game.update!(player_1_cruiser_count: game.player_1_cruiser_count - 1)
      end
    elsif player_number == 'player_2'
      if ship.type == 'destroyer'
        game.update!(player_2_destroyer_count: game.player_2_destroyer_count - 1)
      elsif ship.type == 'cruiser'
        game.update!(player_2_cruiser_count: game.player_2_cruiser_count - 1)
      end
    end

    updated_game = Game.find(params[:game_id])

    # render json for game and message
    render json: game, message: GameMessagesService.new(game: updated_game, ship: ship, player_number_string: player_number).ship_placement_feedback
  end
end
