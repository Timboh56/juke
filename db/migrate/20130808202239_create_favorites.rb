class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :users
      t.references :bars
      t.timestamps
    end
  end
end
