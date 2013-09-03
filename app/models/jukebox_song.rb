class JukeboxSong < ActiveRecord::Base
  attr_accessible  :rank, :scheduled, :jukebox_id, :song_id, :user_id
  belongs_to :jukebox
  belongs_to :song
  belongs_to :user
  has_many :votes, :dependent => :destroy, :counter_cache => true
  scope :songs_for_jukebox, lambda { |jukebox_id| 
    jukeboxsongs_arel = JukeboxSong.arel_table
    songs = where(jukeboxsongs_arel[:jukebox_id].eq(jukebox_id))
  }
  default_scope order("rank ASC").limit(4)
  validates_uniqueness_of :song_id, :scope => [:jukebox_id, :song_id], :message => "Your selected song has already been submitted!"
  after_create(:add_vote_for_jukebox_song)
  
  def add_vote_for_jukebox_song
    self.votes << Vote.new(:user_id => self.user_id, :jukebox_id => self.jukebox_id)
    self.save!
  end

  def song_title
    song.name
  end
  
  def artist
    song.artist
  end
end
