class List < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  enum status: %i[privada publica]
end
