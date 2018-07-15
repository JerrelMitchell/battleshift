class AddShipCountsToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player1_destroyer_count, :integer, default: 1
    add_column :games, :player1_cruiser_count, :integer, default: 1
    add_column :games, :player2_destroyer_count, :integer, default: 1
    add_column :games, :player2_cruiser_count, :integer, default: 1
  end
end
