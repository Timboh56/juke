class CreateJukeboxSongs < ActiveRecord::Migration
  def change
    create_table :jukebox_songs do |t|
      t.integer :rank
      t.integer :votes_count
      t.references :song, :null => false
      t.references :jukebox, :null => false
      t.references :user, :null => false
      t.time :scheduled
      t.timestamps
    end
    add_index :jukebox_songs, :song_id
    add_index :jukebox_songs, :jukebox_id
    add_index :jukebox_songs, :user_id
  end
end
