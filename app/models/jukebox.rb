class Jukebox < ActiveRecord::Base
  attr_accessible :city, :closing, :country, :latitude, :longitude, :name, :opening, :state, :street, :url
  has_many :favorites, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :jukebox_songs, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
