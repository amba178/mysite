class AddCvvToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :card_cvv, :integer
  end
end
