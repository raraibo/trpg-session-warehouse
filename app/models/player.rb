class Player < ApplicationRecord
  has_many :session_players
  has_many :sessions, through: :session_players
end
