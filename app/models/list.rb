class List < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  enum status: %i[privada publica]

  scope :public_lists, ->(user) { where('status = ? AND user_id != ?', 1, user) }
end
