class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :jukebox
  attr_accessible :amount, :song_artist, :song_name
end
