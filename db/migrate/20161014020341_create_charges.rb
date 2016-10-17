class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.integer :card_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on
      t.string :billing_address
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
