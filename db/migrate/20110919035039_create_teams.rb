class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
