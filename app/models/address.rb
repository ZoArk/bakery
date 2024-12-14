class Address < ApplicationRecord
  belongs_to :user
  belongs_to :addressable, polymorphic: true
  validates :street_address, :city, :province, :postal_code, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true, format: { with: /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/, message: "must be in the format A1A 1A1" }
end
