class List < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :favorites
  has_many :tasks, inverse_of: :list, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :title, presence: true

  enum status: %i[privada publica]

  scope :public_lists, ->(user) { where('status = ? AND user_id != ?', 1, user) }
end
