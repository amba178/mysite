class RemoveVideoRefeToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_reference :posts, :video, foreign_key: true, index: true
  end
end
