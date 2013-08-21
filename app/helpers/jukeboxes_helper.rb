module JukeboxesHelper
  
  def playlist(songs)
    if songs && !songs.empty?
      songs.each do |song|
  	    song.song_title
  	  end
    else 
      "There are no songs submitted yet!"
    end
  end
  
  def location(jukebox)
    if !jukebox.street.empty? && !jukebox.city.empty? && !jukebox.state.empty? && !jukebox.country.empty?
      content_tag(:p, "Located at " + jukebox.street + ", " + jukebox.city + "," + jukebox.state + "," + jukebox.country)
    end
  end
end
