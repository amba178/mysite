class RemoveCardIdFromCharges < ActiveRecord::Migration[5.0]
  def change
    remove_column :charges, :card_id, :integer
  end
end
