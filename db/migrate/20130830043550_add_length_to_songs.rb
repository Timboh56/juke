class AddLengthToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :length, :integer, :null => false, :default => 0
  end

  def down
    remove_column :songs, :length
  end
end
