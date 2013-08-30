class AddUniqueIndexToSongs < ActiveRecord::Migration
  def change
    add_index :songs, [:name, :artist ], :unique => true

  end
end
