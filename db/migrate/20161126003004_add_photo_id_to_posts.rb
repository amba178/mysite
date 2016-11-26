class AddPhotoIdToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_reference :posts, :photo, index: true
  end
end
