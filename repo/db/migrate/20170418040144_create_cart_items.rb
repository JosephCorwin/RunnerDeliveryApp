class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price, precision: 12, scale: 3

      t.timestamps
    end
  end
end
