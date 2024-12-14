class Product < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items
  belongs_to :user, optional: true
  belongs_to :category
  has_one_attached :image
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
