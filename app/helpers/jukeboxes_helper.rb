module JukeboxesHelper
  
  def playlist(songs)
    if songs && !songs.empty?
      render :partial => "playlist", :locals => { :songs => songs}
    else 
      "There are no songs submitted yet!"
    end
  end
  
  def location(jukebox)
    if !jukebox.street.empty? && !jukebox.city.empty? && !jukebox.state.empty? && !jukebox.country.empty?
      content_tag(:p, "Located at " + jukebox.street + ", " + jukebox.city + "," + jukebox.state + "," + jukebox.country)
    end
  end
  
  def new_song(jukebox)
    @jukebox = jukebox
    if current_user
      render :partial => "new_song", :locals => {:jukebox => @jukebox}
    end
  end
end
