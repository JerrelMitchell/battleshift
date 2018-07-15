class AddShipCountsToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1_destroyer_count, :integer, default: 1
    add_column :games, :player_1_cruiser_count, :integer, default: 1
    add_column :games, :player_2_destroyer_count, :integer, default: 1
    add_column :games, :player_2_cruiser_count, :integer, default: 1
  end
end
