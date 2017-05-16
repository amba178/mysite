class AddProcessedToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :video_processing, :boolean, default: false 
  end
end