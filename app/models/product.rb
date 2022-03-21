class Product < ApplicationRecord

  MIN_LENGTH             = 2
  MAX_NAME_LENGTH        = 100
  MAX_DESCRIPTION_LENGTH = 1000

  validates_presence_of :name, :description
  validates :name, length: { in: MIN_LENGTH..MAX_NAME_LENGTH }
  validates :description, length: { in: MIN_LENGTH..MAX_DESCRIPTION_LENGTH }

  scope :recent, -> { order(created_at: :desc) }
  # scope :recent, -> { order(id: :desc) }
  
  after_create_commit do 
    broadcast_prepend_later_to(:products, target: 'products_list')
    # broadcast_prepend_to(:products, target: 'products_list')
  end

  after_update_commit do
    broadcast_replace_later_to(:products, target: self)
    # broadcast_update_to(:products, target: 'products_list')
  end

  after_destroy_commit do
    broadcast_remove_to :products
  end
end
