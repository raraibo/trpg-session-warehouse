class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string     :scenario_name, null: false
      t.string     :system_name,   null: false # 文字列のソートって遅い？SystemIdとかを振るべき？
      t.datetime   :play_date # atteru?
      # GM
      t.references :gm, foreign_key: { to_table: :players }
      # Player
      t.references :player, foreign_key: true
      # archive_url_1.2.3..
      t.references :archive
      # プレイ時間
      t.string     :play_time
      # PL人数
      t.integer    :number_of_people
      # 備考
      t.text       :note
      t.timestamps
    end
  end
end
