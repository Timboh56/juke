class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar
  attr_accessible :amount, :song_artist, :song_name
end
