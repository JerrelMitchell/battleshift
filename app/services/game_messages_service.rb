class GameMessagesService
  def initialize(player, payload:)
    @player = player
    @payload = payload
  end

  def placed_ship_size
    @payload[:ship_size]
  end

  def player_remaining_ships
    player_ships = @player.ships
    player_ships.each do |ship, count|
      player_ships.delete(ship) if count == 0
    end
    player_ships
  end

  def remaining_ship_size(ship)
    return 2 if ship == :cruisers
    return 3 if ship == :destroyers
  end

  def ship_placement_feedback
    if @player.ships.values.sum > 0
      "Successfully placed ship with a size of #{placed_ship_size}. You have #{player_remaining_ships.values.sum} ship(s) to place with a size of #{remaining_ship_size(player_remaining_ships.keys.first)}."
    end
  end
end
