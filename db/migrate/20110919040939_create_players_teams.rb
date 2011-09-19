class CreatePlayersTeams < ActiveRecord::Migration
  def change
    create_table :players_teams, :id => false do |t|
      t.integer :player_id, :null => false
      t.integer :team_id, :null => false

      t.timestamps
    end
  end
end
