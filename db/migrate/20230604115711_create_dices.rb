class CreateDices < ActiveRecord::Migration[6.1]
  def change
    create_table :dices do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :value
      t.boolean :locked

      t.timestamps
    end
  end
end
