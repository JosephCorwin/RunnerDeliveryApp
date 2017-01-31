class AddStuffToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :image, :string
    add_column :stores, :featured, :string
    add_column :stores, :contact_name, :string
    add_column :stores, :contact_phone, :string
  end
end
