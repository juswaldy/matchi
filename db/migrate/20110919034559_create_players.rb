class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.string :number
      t.integer :score, :default => 0
      t.integer :assist, :default => 0

      t.timestamps
    end
  end
end
