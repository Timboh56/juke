class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false,  :default => ''
      t.string :username, :null => false
      t.string :crypted_password, :null => false
      t.text :blurb
      t.string :persistence_token, :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token, :null => false
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.string :current_login_ip
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.timestamps
    end
  end
end
