class List < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :favorites
  validates :title, presence: true
  enum status: %i[privada publica]

  scope :public_lists, ->(user) { where('status = ? AND user_id != ?', 1, user) }
end
