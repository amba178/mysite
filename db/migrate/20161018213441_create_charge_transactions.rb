class CreateChargeTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :charge_transactions do |t|
      t.integer :charge_id
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps
    end
  end
end
