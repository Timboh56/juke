class AddNotNullToJukeboxes < ActiveRecord::Migration
  def change
    change_column :jukeboxes, :street, :string, :null => false
    change_column :jukeboxes, :city, :string, :null => false
    change_column :jukeboxes, :state, :string, :null => false
  end
end
