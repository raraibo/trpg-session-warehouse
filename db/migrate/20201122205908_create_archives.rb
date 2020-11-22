class CreateArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :archives do |t|
      t.text :url
      t.timestamps
    end
  end
end
