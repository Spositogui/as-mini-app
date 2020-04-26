class List < ApplicationRecord
  belongs_to :user
  enum status: %i[privada publica]
end
