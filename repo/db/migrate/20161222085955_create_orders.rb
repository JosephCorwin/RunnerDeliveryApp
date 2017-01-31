class CreateOrders < ActiveRecord::Migration[5.0]
  def change

    create_table :runners do |t|
      t.references :user, forgein_key: true

      t.timestamps
    end

    create_table :customers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :runner
      t.text :what_they_want
      t.string :where_it_goes
      t.string :where_to_get

      t.timestamps
    end

  end
end
