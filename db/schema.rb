# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130824082341) do

  create_table "bids", :force => true do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "jukebox_id"
    t.string   "song_name"
    t.string   "song_artist"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "bids", ["jukebox_id"], :name => "index_bids_on_jukebox_id"
  add_index "bids", ["song_name"], :name => "index_bids_on_song_name"
  add_index "bids", ["user_id"], :name => "index_bids_on_user_id"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "jukebox_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["jukebox_id"], :name => "index_favorites_on_jukebox_id"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "jukeboxes", :force => true do |t|
    t.string   "name",       :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "url"
    t.time     "opening"
    t.time     "closing"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "", :null => false
    t.string   "username",                            :null => false
    t.string   "crypted_password",                    :null => false
    t.text     "blurb"
    t.string   "persistence_token",                   :null => false
    t.string   "single_access_token",                 :null => false
    t.string   "perishable_token",                    :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.string   "current_login_ip"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "jukebox_id", :null => false
    t.string   "song_title", :null => false
    t.string   "artist",     :null => false
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["jukebox_id"], :name => "index_votes_on_jukebox_id"
  add_index "votes", ["song_title"], :name => "index_votes_on_song_title"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
