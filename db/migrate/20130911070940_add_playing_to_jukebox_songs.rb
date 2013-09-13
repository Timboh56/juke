class AddPlayingToJukeboxSongs < ActiveRecord::Migration
  def up
    add_column :jukebox_songs, :playing, :boolean, :default => false
  end

  def down
    remove_column :jukebox_songs, :playing
  end
end
