class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :users
      t.references :roles
      t.timestamps
    end
  end
end
