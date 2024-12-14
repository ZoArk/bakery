class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product, presence: true

  # Optionally, add validations to ensure quantity is always greater than 0
  validates :quantity, numericality: { greater_than: 0 }
end
