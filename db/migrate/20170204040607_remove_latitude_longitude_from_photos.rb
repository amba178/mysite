class RemoveLatitudeLongitudeFromPhotos < ActiveRecord::Migration[5.0]
  def change
  	remove_column :photos, :address, :string
    remove_column :photos, :latitude, :float
    remove_column :photos, :longitude, :float
    remove_column :photos, :description, :text 
  end
end
