class Session < ApplicationRecord
  has_many :session_players
  has_many :players, through: :session_players
end
