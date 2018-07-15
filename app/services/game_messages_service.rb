class GameMessagesService
  def initialize(game: nil, ship: nil)
    @game = game
    @ship = ship
    # @player = player
    # @ships = {
    #   destroyer: @game["#{player_number_string}_destroyer_count"],
    #   cruiser: @game["#{player_number_string}_cruiser_count"]
    # }
  end

  def ships
    if @game.current_turn == 'challenger'
      {
        destroyer: @game["player_1_destroyer_count"],
        cruiser: @game["player_1_cruiser_count"]
      }
    elsif @game.current_turn == 'opponent'
      {
        destroyer: @game["player_2_destroyer_count"],
        cruiser: @game["player_2_cruiser_count"]
      }
    end
  end

  def placed_ship_size
    @ship.length
  end

  def player_remaining_ships
    player_ships = ships
    player_ships.each do |ship, count|
      player_ships.delete(ship) if count == 0
    end
    player_ships
  end
  
  def remaining_ship_size(ship)
    return 2 if ship == :cruiser
    return 3 if ship == :destroyer
  end
  
  def ship_placement_feedback
    if ships.values.sum > 0
      "Successfully placed ship with a size of #{placed_ship_size}. You have #{ships.values.sum} ship(s) to place with a size of #{remaining_ship_size(player_remaining_ships.keys.first)}."
    elsif ships.values.sum == 0
      "Successfully placed ship with a size of #{placed_ship_size}. You have 0 ship(s) to place."
    end
  end

  def not_your_turn
    { message: 'Invalid move. It\'s your opponent\'s turn'}
  end
end
