class Song < ActiveRecord::Base
  attr_accessible :artist, :name, :album, :url
  has_many :jukebox_songs, :dependent => :destroy
  
  searchable do
    text :artist, :name, :album  
  end
end
