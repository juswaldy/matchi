class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.date :date
      t.integer :team1id
      t.integer :team2id
      t.integer :team1score, :default => 0
      t.integer :team2score, :default => 0

      t.timestamps
    end
  end
end
