class Jukebox < ActiveRecord::Base
  attr_accessible :city, :closing, :country, :latitude, :longitude, :name, :opening, :state, :street, :url
  has_many :favorites, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :jukebox_songs, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :user
  scope :not_user_jukeboxes, lambda { 
    |user| 
    arel = Jukebox.arel_table
    where(arel[:user_id].not_eq(user.id)) 
  }
  scope :user_jukeboxes, lambda { |user| where(:user_id => user.id) }
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def set_current_song!
    jukebox_song = current_song
    
    # if current_song is not set, set it
    if jukebox_song.nil?
      
      # if a jukebox_song with rank 0 is not found, 
      # the playlist has not been ranked and needs to do so
      if jukebox_songs.find_by_rank(0).nil?
        rank!
      end
      
      jukebox_song = jukebox_songs.find_by_rank(0)

      jukebox_song.playing = true
      jukebox_song.save
    end
    
    return jukebox_song
    
  end
  
  def current_song
    
    # look for jukebox_songs that are playing
    jukebox_song ||= jukebox_songs.find_by_playing(true)
  end
  
  def current_song_set?
    return !jukebox_songs.find_by_playing(true).nil?
  end
  
  def empty_playlist?
    return jukebox_songs.empty?
  end
  
  # rank ranks all songs in the playlist based on votes submitted
  # rank is called after a song finishes playing, when a jukebox_song is added, 
  # a jukebox_song is deleted, when a vote is added, a vote is deleted
  def rank!
    
    # keep an array of arrays of size 2, with index 0 being 
    # the jukebox_song_id, index 1 being the number of votes for that jukebox_song
    vote_counts = []
    
    jukebox_songs.each do |jukebox_song|
      vote_counts.push([jukebox_song.id, jukebox_song.votes_count])
    end

    # sort the array by vote count
    vote_counts.sort_by! { |arr|
      arr[1]
    }.reverse!
            
    # assign rankings
    # if rankings have already been assigned to jukebox songs of this jukebox with jukebox_id,
    # skip jukebox_song with ranking of 0 because that's the currently playing jukebox_song
    vote_counts.each_with_index do |arr,i|
      id = arr[0]
      jukebox_song = jukebox_songs.find(id)
      
      # start with 0, rank 0 is current song playing
      jukebox_song.rank = i
      
      jukebox_song.save
    end
  end
end
