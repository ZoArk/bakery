class Cart < ApplicationRecord
  belongs_to :user, optional: true  # Allows for guest carts without user_id being required
  has_many :cart_items
  has_many :products, through: :cart_items


  validates :session_id, uniqueness: true, allow_nil: true

  def add_product(product)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity += 1
    cart_item.save
  end
end
