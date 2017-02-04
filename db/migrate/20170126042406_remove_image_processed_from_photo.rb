class RemoveImageProcessedFromPhoto < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :image_processed, :boolean
  end
end
