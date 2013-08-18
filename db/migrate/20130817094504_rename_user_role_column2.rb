class RenameUserRoleColumn2 < ActiveRecord::Migration
  def up
    rename_column :user_roles, :roles_id, :role_id
  end

  def down
    rename_column :user_roles, :role_id, :roles_id
  end
end
