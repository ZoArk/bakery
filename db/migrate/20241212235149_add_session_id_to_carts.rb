class AddSessionIdToCarts < ActiveRecord::Migration[7.2]
  def change
    add_column :carts, :session_id, :string
  end
end
