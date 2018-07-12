class AddPlayerToUserGameTable < ActiveRecord::Migration[5.1]
  def change
    add_column :user_games, :player, :integer, default: 0
  end
end
