class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end

  def excel
    xlsx = Roo::Excelx.new('./session.xlsx')

    # headers = id:, name:
    headers = xlsx.row(1)
    xlsx.each_row_streaming(max_rows: 1) do |row|
      # session = Session.create!()
      # puts row.class
      row.each_with_index do |cell, index|
        # puts headers[index]

        case headers[index]
        when "時間" # 1.5|2.0h とか記法がバラバラなのでto_i
          puts cell.cell_value.to_i
        when cell.formula? # hyperlinkの式を取得するため
          puts cell.formula
        else
          puts cell.cell_value
        end
      end
    end
  end
end
