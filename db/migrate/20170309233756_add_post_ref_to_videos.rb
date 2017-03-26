class AddPostRefToVideos < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :video, foreign_key: true
  end
end
