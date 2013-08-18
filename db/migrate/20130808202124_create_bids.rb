class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :amount
      t.references :user
      t.references :jukebox
      t.string :song_name
      t.string :song_artist

      t.timestamps
    end
    add_index :bids, :user_id
    add_index :bids, :jukebox_id
    add_index :bids, :song_name
  end
end
