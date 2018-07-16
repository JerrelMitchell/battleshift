class AddPlayerShipsToUserGames < ActiveRecord::Migration[5.1]
  def change
    add_column :user_games, :player_ships, :integer, default: 2
  end
end
