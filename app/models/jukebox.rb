class Jukebox < ActiveRecord::Base
  attr_accessible :city, :closing, :country, :latitude, :longitude, :name, :opening, :state, :street, :url
  has_many :favorites, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :jukebox_songs, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :user
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def set_current_song!
    jukebox_song = jukebox_songs.find_by_rank(0)
    jukebox_song.playing = true
    jukebox_song.save
  end
  
  def current_song
    
    # look for jukebox_songs that are playing
    @jukebox_song ||= jukebox_songs.find_by_playing(true)
  end
  
  def empty?
    return jukebox_songs.empty? || jukebox_songs.nil?
  end
end
