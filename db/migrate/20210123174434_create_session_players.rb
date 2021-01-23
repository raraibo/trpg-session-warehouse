class CreateSessionPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :session_players do |t|
      t.belongs_to :session
      t.belongs_to :player
      t.timestamps
    end
  end
end
