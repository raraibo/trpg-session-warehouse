class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end

  def google_drive
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      scope: %w(https://www.googleapis.com/auth/drive https://spreadsheets.google.com/feeds/),
      redirect_uri: 'http://example.com/redirect'
    )
    credentials.refresh_token = ENV['GOOGLE_REFRESH_TOKEN']
    credentials.fetch_access_token!
    session = GoogleDrive::Session.from_credentials(credentials)

    ws = session.spreadsheet_by_key("xxxxxxxxxxxxxxxxxxxxxxxxxxx").worksheets[0]

    p ws[0, 0]
  end
end
