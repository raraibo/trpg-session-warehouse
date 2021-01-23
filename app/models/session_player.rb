class SessionPlayer < ApplicationRecord
  belongs_to :session
  belongs_to :player
end
