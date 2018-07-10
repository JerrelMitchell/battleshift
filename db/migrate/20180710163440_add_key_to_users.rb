class AddKeyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :key, :string, null: true
  end
end
