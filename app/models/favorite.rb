class Favorite < ActiveRecord::Base
  attr_accessible :jukebox_id
  belongs_to :user
  belongs_to :jukebox
end
