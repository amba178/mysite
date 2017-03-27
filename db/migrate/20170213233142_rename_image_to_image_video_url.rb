class RenameImageToImageVideoUrl < ActiveRecord::Migration[5.0]
  def change
  	rename_column :photos, :image, :image_video_url
  end
end
