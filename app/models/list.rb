class List < ApplicationRecord
  belongs_to :user
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :title, presence: true

  enum status: %i[privada publica]
end
