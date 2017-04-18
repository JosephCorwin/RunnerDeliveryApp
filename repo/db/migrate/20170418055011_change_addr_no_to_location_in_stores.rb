class ChangeAddrNoToLocationInStores < ActiveRecord::Migration[5.0]
  def change
  	add_column :stores, :location, :string
  	remove_column :stores, :addr_no
  end
end
