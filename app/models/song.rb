class Song < ActiveRecord::Base
  attr_accessible :artist, :name, :album, :url, :length
  has_many :jukebox_songs, :dependent => :destroy
  validates_uniqueness_of :name, :scope => [:artist], :message => "This song has already been submitted."
  before_save(:file_info)
    
  searchable do
    text :artist, :name, :album  
  end
  
  def file_info
    require 'taglib'
    
    # Load file from name
    TagLib::FileRef.open("public/tunes/" + self.name + ".mp3") do |fileref|
      unless fileref.null?
        song_info = tag = fileref.tag
        tag.title   #=> "Wake Up"
        tag.artist  #=> "Arcade Fire"
        tag.album   #=> "Funeral"
        tag.year    #=> 2004
        tag.track   #=> 7
        tag.genre   #=> "Indie Rock"
        tag.comment #=> nil

        properties = fileref.audio_properties
        properties.length  #=> 335 (song length in seconds)
        self.length = properties.length
        
      end
    end  # File is automatically closed at block end
  end
end
