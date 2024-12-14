class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :province
      t.string :postal_code
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end