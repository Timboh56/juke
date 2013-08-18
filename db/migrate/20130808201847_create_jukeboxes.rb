class CreateJukeboxes < ActiveRecord::Migration
  def change
    create_table :jukeboxes do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :url
      t.time :opening
      t.time :closing

      t.timestamps
    end
  end
end
