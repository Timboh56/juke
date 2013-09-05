class AddUserColumnToJukeboxes < ActiveRecord::Migration
  def change
    add_column :jukeboxes, :user_id, :integer
  end
end
