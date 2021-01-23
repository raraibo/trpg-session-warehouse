class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end

  def excel
    xlsx = Roo::Excelx.new('./session.xlsx')

    # headers = id:, name:
    headers = xlsx.row(1)
    column_name_headers = {
      "GM" => "gm",
      "システム" => "system_name",
      "シナリオ名" => "scenario_name",
      "プレイ日" => "play_date",
      "プレイヤー" => "player",
      "プラットフォーム" => "platform",
      "時間" => "play_time",
      "PL数" => "number_of_people",
      "備考" => "note",
    }

    for num in 1..12 do
      if num <= 5
        column_name_headers["備考#{num}"] = "note"
      end

      column_name_headers["アーカイブ#{num}"] = "archive"
    end

    xlsx.each_row_streaming(max_rows: 1) do |row|
      # createはその場で保存される(create!なら失敗すると例外を投げてくる)
      session = Session.new
      row.each_with_index do |cell, index|
        case column_name_headers[headers[index]]
        when "gm"
          gm = Player.where(name: cell.cell_value)
          gm = Player.new if gm.blank?
          gm.name = cell.cell_value
          session.gm_id = gm # TODO : 入ってない、gm_id?
        when "play_date"
          # puts cell
          session.play_date = cell # TODO : 入ってない
        when "player"
          cell.cell_value.split("、").each do |name|
            player = Player.where(name: name)
            player = Player.new if player.blank?
            player.name = name
            session.players << player
          end
        when "play_time" # 1.5|2.0h とか記法がバラバラなのでto_i
          session.play_time = cell.cell_value.to_i
        when "archive" # TODO
          # puts cell.formula # hyperlinkの式を取得するため
          # session.
        when "platform" # TODO
        else
          session.write_attribute("#{column_name_headers[headers[index]]}", cell.cell_value)
        end
      end

      session.save
    end
  end
end
