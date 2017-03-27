class RemovePhotoRefeToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_reference :posts, :photo, index: true
  end
end
