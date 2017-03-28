class AddColumnToVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :uid, :string
    add_index :videos, :uid
  end
end
