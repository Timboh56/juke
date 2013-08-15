class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.text :blurb
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.timestamps
    end
  end
end
