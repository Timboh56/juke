class JukeboxSong < ActiveRecord::Base
  attr_accessible  :rank, :scheduled
  belongs_to :jukebox
  belongs_to :song
  belongs_to :user
  has_many :votes, :dependent => :destroy
  
  def song_title
    song.name
  end
  
  def artist
    song.artist
  end
end
