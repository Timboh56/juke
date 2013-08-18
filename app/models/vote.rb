class Vote < ActiveRecord::Base
  belongs_to :user
  attr_accessible :artist, :song_title, :url
  scope :todays_votes, lambda { Vote.where("created_at = ? ", Time.zone.now.beginning_of_day) }
  scope :user_votes, lambda { |user| Vote.where(:user_id => user.id) }
end
