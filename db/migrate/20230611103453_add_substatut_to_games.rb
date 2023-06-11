class AddSubstatutToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :substatut, :string
  end
end
