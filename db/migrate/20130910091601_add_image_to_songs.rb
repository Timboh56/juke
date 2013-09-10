class AddImageToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :image_url, :string
  end

  def down
    remove_column :songs, :image_url
  end
end
