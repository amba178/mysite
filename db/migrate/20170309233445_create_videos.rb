class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
