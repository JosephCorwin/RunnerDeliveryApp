class AddPrimaryAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :primary_address, :integer
  end
end
