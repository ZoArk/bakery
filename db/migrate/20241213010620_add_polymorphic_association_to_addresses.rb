class AddPolymorphicAssociationToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_reference :addresses, :addressable, polymorphic: true, null: false
  end
end
