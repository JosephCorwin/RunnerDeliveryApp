class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :adr_street
      t.string :adr_street2
      t.string :adr_city
      t.string :adr_state
      t.string :adr_zip
      t.string :status
      t.timestamps
    end
    add_index :users, :email, unique:true
  end
end
