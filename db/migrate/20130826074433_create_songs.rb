class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, :null => false, :empty => false
      t.string :artist, :null => false, :empty => false
      t.string :album
      t.string :url, :null => false, :empty => false
      t.timestamps
    end
    add_index :songs, :name
    add_index :songs, :artist
    add_index :songs, :album
  end
end
