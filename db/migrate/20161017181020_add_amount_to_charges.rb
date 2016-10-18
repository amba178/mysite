class AddAmountToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :amount, :integer
  end
end
