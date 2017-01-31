class CreateDispatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :dispatchers do |t|
      t.references :user

      t.timestamps
    end
  end
end
