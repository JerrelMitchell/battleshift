class GameMessagesService
  # def initialize(user, payload:)
  #   @user    = user
  #   @payload = payload
  # end

  def initialize(game: nil, ship: nil, player_number_string: nil)
    @game = game
    @ship = ship
    @player = player_number_string
    # require 'pry';binding.pry
    @ships = {
      destroyer: @game["#{player_number_string}_destroyer_count"],
      cruiser: @game["#{player_number_string}_cruiser_count"]
    }
  end

  def placed_ship_size
    @ship.length
  end

  def player_remaining_ships
    player_ships = @ships
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
    if @ships.values.sum > 0
      "Successfully placed ship with a size of #{placed_ship_size}. You have #{@ships.values.sum} ship(s) to place with a size of #{remaining_ship_size(player_remaining_ships.keys.first)}."
    elsif @ships.values.sum == 0
      "Successfully placed ship with a size of #{placed_ship_size}. You have 0 ship(s) to place."
    end
    # "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
  end
end
