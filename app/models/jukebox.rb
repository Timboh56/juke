class Jukebox < ActiveRecord::Base
  attr_accessible :city, :closing, :country, :latitude, :longitude, :name, :opening, :state, :street, :url
  has_many :favorites
  has_many :bids
  has_many :votes
end
