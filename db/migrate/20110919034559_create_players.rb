class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.string :number
      t.integer :score
      t.integer :assist

      t.timestamps
    end
  end
end
