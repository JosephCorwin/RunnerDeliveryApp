class AddMoreTimestampsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :time_obtained, :datetime
    add_column :orders, :time_delivered, :datetime
  end
end
