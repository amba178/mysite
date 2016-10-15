class RemoveCvvFromCharges < ActiveRecord::Migration[5.0]
  def change
    remove_column :charges, :card_cvv, :string
  end
end
