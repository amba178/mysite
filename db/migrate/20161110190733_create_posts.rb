class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :commentable_id
      t.string  :commentable_type
      t.timestamps
    end
    add_index :posts, [:commentable_type, :commentable_id]
  end
end
