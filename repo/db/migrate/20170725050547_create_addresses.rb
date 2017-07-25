class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :location, polymorphic: true, index: true
      t.timestamps
    end
  end
end
