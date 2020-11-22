class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, :null false
      t.string :twitter_id
      t.string :youtube_url
      t.string :note
      t.string :color_code
      t.boolean :is_white_named, default: false
      t.timestamps
    end
  end
end
