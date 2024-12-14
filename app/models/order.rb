class Order < ApplicationRecord
  attr_accessor :card_number, :expiry_date, :cvc
  belongs_to :user
  has_many :order_items
  has_one :address, as: :addressable
  # Optional: has_one :payment (if you want to track payment info)
  enum status: { pending: 0, paid: 1, shipped: 2, delivered: 3 }

  # Add validations (if necessary)
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending processing completed canceled] }
  validates :order_date, presence: true
  # Optional: Add any custom methods if needed
end
