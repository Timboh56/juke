class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, :null => false
      t.references :jukebox, :null => false
      t.string :song_title, :null => false
      t.string :artist, :null => false
      t.string :url

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :song_title
    add_index :votes, :jukebox_id
    
  end
end
