class JukeboxSong < ActiveRecord::Base
  attr_accessible  :rank, :scheduled, :jukebox_id, :song_id
  belongs_to :jukebox
  belongs_to :song
  belongs_to :user
  has_many :votes, :dependent => :destroy
  scope :songs_for_jukebox, lambda { |jukebox_id| 
    jukeboxsongs = JukeboxSong.arel_table
    songs = JukeboxSong.where(jukeboxsongs[:jukebox_id].eq(jukebox_id))
  }
  default_scope order("rank ASC").limit(4)
  validates_uniqueness_of :song_id, :scope => [:jukebox_id, :song_id, :user_id], :message => "You have already submitted this song"
  
  def song_title
    song.name
  end
  
  def artist
    song.artist
  end
end
