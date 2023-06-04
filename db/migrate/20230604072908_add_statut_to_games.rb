class AddStatutToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :statut, :string
  end
end
