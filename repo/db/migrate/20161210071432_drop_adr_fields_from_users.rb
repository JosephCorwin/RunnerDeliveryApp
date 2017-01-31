class DropAdrFieldsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_columns(:users, :adr_street, :adr_street2, :adr_city, :adr_state, :adr_zip)
  end
end
