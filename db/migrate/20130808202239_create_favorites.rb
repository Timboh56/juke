class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.references :jukebox
      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :jukebox_id
  end
end
