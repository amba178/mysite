class AddImageProcessedToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :image_processed, :boolean, default: false 
  end
end
