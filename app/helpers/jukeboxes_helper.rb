module JukeboxesHelper
  
  def jukebox_title_div(jukebox, favorite)
    render :partial => "jukebox_title_div", :locals => { :jukebox => jukebox, :favorite => favorite }
  end
  
  def playlist(songs)
    render :partial => "playlist2", :locals => { :songs => songs}
  end
  
  def location(jukebox)
    if !jukebox.street.empty? && !jukebox.city.empty? && !jukebox.state.empty? && !jukebox.country.empty?
      content_tag(:div, "Located at " + jukebox.street + ", " + jukebox.city + "," + jukebox.state + "," + jukebox.country, :class => "location")
    end
  end
  
  def search_song(jukebox)
    @jukebox = jukebox
    if current_user
      render :partial => "search_song", :locals => { :jukebox => @jukebox }
    end
  end
  
  def jplayer(jukebox)
    if user_authorized_for_object?(jukebox) && !jukebox.empty_playlist?
      render :partial => "jplayer"
    end
  end
  
  def jukebox_chat
    if current_user
      render :partial => "chat"
    end
  end
end
