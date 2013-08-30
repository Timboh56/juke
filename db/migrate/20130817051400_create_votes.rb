class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, :null => false
      t.references :jukebox, :null => false
      t.references :jukebox_song, :null => false
      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :jukebox_id
    add_index :votes, :jukebox_song_id
    
  end
end
