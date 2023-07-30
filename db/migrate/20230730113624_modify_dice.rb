class ModifyDice < ActiveRecord::Migration[6.1]
  def change
    add_column :dices, :state, :string
    remove_column :dices, :locked
  end
end
