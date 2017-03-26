class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :image
      t.references :commentable, polymorpic: true, index: true  
      t.timestamps
    end
    
  end
end
