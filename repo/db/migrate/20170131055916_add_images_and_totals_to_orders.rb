class AddImagesAndTotalsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :receipt, :string
    add_column :orders, :retail_total, :decimal, :precision => 8, :scale => 2
  end
end
