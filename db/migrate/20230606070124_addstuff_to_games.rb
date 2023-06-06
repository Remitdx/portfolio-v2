class AddstuffToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :turn, :integer
    add_column :games, :current_player, :string
    add_column :games, :sum, :integer
  end
end
