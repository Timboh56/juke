class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :jukebox
  belongs_to :jukebox_song
  attr_accessible :jukebox_id, :jukebox_song_id
  scope :todays_votes, lambda { Vote.where("created_at = ? ", Time.zone.now.beginning_of_day) }
  scope :user_votes, lambda { |user| Vote.where(:user_id => user.id) }
  scope :jukebox_votes, lambda { |jukebox_id| where(:jukebox_id => jukebox_id) }
  validates_presence_of :jukebox_id
  validates_presence_of :jukebox_song_id
  validates_uniqueness_of :user_id, :scope => [:jukebox_id, :jukebox_song_id], :message => "You have already submitted that"
  before_destroy(:decrement_jukebox_song_count)
  
  def decrement_jukebox_song_count
    # CHANGE TO USE INVERSE_OF INSTEAD OF USING WHERE
    jukebox_song = JukeboxSong.where(:id => self.jukebox_id).first
    jukebox_song.votes_count -= 1
    jukebox_song.save!
  end

end
