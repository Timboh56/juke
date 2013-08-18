class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :jukebox
      t.string :song_title
      t.string :artist
      t.string :url

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :song_title
    add_index :votes, :jukebox_id
    
  end
end
