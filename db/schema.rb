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

ActiveRecord::Schema.define(:version => 20130913025243) do

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "jukebox_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["jukebox_id"], :name => "index_favorites_on_jukebox_id"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "jukebox_songs", :force => true do |t|
    t.integer  "rank"
    t.integer  "votes_count", :default => 0
    t.integer  "song_id",                        :null => false
    t.integer  "jukebox_id",                     :null => false
    t.integer  "user_id",                        :null => false
    t.time     "scheduled"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "playing",     :default => false
  end

  add_index "jukebox_songs", ["jukebox_id"], :name => "index_jukebox_songs_on_jukebox_id"
  add_index "jukebox_songs", ["song_id"], :name => "index_jukebox_songs_on_song_id"
  add_index "jukebox_songs", ["user_id"], :name => "index_jukebox_songs_on_user_id"

  create_table "jukeboxes", :force => true do |t|
    t.string   "name",       :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street",     :null => false
    t.string   "city",       :null => false
    t.string   "state",      :null => false
    t.string   "country"
    t.string   "url"
    t.time     "opening"
    t.time     "closing"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "songs", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "artist",                    :null => false
    t.string   "album"
    t.string   "url",                       :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "length",     :default => 0, :null => false
    t.string   "image_url"
  end

  add_index "songs", ["album"], :name => "index_songs_on_album"
  add_index "songs", ["artist"], :name => "index_songs_on_artist"
  add_index "songs", ["name", "artist"], :name => "index_songs_on_name_and_artist", :unique => true
  add_index "songs", ["name"], :name => "index_songs_on_name"

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
    t.integer  "user_id",         :null => false
    t.integer  "jukebox_id",      :null => false
    t.integer  "jukebox_song_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "votes", ["jukebox_id"], :name => "index_votes_on_jukebox_id"
  add_index "votes", ["jukebox_song_id"], :name => "index_votes_on_jukebox_song_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
