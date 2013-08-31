class Vote < ActiveRecord::Base
  attr_accessible :jukebox_id, :jukebox_song_id, :user_id
  belongs_to :user
  belongs_to :jukebox
  belongs_to :jukebox_song
  scope :todays_votes, lambda { Vote.where("created_at = ? ", Time.zone.now.beginning_of_day) }
  scope :user_votes, lambda { |user| Vote.where(:user_id => user.id) }
  scope :jukebox_votes, lambda { |jukebox_id| where(:jukebox_id => jukebox_id) }
  scope :jukebox_song_votes, lambda { |jukebox_song_id| where(:jukebox_song_id => jukebox_song_id) }
  
  validates_presence_of :jukebox_id
  validates_presence_of :jukebox_song_id
  validates_uniqueness_of :user_id, :scope => [:jukebox_id, :jukebox_song_id], :message => "You have already submitted that"
  after_destroy(:update_jukebox_song_count)
  after_create(:update_jukebox_song_count)
  
  def update_jukebox_song_count
    jukebox_song = JukeboxSong.find(self.jukebox_song_id)
    count = Vote.jukebox_song_votes(self.jukebox_song_id).count
    jukebox_song.votes_count = count
    jukebox_song.save!
  end

end
