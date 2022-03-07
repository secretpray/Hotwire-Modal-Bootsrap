class Product < ApplicationRecord

  MIN_LENGTH             = 2
  MAX_NAME_LENGTH        = 100
  MAX_DESCRIPTION_LENGTH = 1000

  validates_presence_of :name, :description
  validates :name, length: { in: MIN_LENGTH..MAX_NAME_LENGTH }
  validates :description, length: { in: MIN_LENGTH..MAX_DESCRIPTION_LENGTH }

  scope :recent, -> { order(created_at: :desc) }
  # scope :recent, -> { order(id: :desc) }
end
