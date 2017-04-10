class AddColumnAuthorToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :author, :string
  end
end
