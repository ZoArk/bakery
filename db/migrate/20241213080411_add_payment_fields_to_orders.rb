class AddPaymentFieldsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :card_number, :string
    add_column :orders, :expiry_date, :string
    add_column :orders, :cvc, :string
  end
end
