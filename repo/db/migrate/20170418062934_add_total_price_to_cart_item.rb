class AddTotalPriceToCartItem < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :total_price, :decimal, precision: 12, scale: 3
  end
end
