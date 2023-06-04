class AddPvToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :pv, :integer
  end
end
