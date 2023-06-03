class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :pseudo

      t.timestamps
    end
  end
end
