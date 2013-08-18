class RenameUserRoleColumns < ActiveRecord::Migration
  def up
    rename_column :user_roles, :users_id, :user_id
  end

  def down
    rename_column :user_roles, :user_id, :users_id
  end
end
