class RemoveLocationFromStore < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :location
  end
end
