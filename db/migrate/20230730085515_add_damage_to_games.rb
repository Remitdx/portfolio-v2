class AddDamageToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :damage, :integer
  end
end
