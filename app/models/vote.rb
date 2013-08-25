class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :jukebox
  attr_accessible :artist, :song_title, :url, :jukebox_id
  scope :todays_votes, lambda { Vote.where("created_at = ? ", Time.zone.now.beginning_of_day) }
  scope :user_votes, lambda { |user| Vote.where(:user_id => user.id) }
  validates_presence_of :artist
  validates_presence_of :song_title

end
