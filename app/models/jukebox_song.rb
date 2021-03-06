class JukeboxSong < ActiveRecord::Base
  attr_accessible  :rank, :scheduled, :jukebox_id, :song_id, :user_id
  belongs_to :jukebox
  belongs_to :song
  belongs_to :user
  has_many :votes, :dependent => :destroy, :inverse_of => :jukebox_song
  scope :songs_for_jukebox, lambda { |jukebox_id| 
    arel = JukeboxSong.arel_table
    
    songs = where(arel[:jukebox_id].eq(jukebox_id)).order("rank ASC")
  }
  validates_uniqueness_of :song_id, :scope => [:jukebox_id, :song_id], :message => "Your selected song has already been submitted!"
  after_create(:add_vote_for_jukebox_song!)

  def add_vote_for_jukebox_song!
    self.votes << Vote.new(:user_id => self.user_id, :jukebox_id => self.jukebox_id)
    save
  end

  def song_title
    song.name
  end
  
  def artist
    song.artist
  end
  
  def url
    song.url
  end

end
