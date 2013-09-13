class ApplicationController < ActionController::Base
  require 'authlogic'
  protect_from_forgery

  helper_method :current_user_session, :current_user, :user_authorized_for_jukebox?, :user_authorized_for_jukebox_song?
  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter(:faye_client)
  before_filter :check_for_mobile

  attr_reader :current_user, :faye_client

  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker",
    "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile",
    "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle",
    "mobile","pda","psp","treo"]

  protected

  def faye_client
    faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
  
  def check_for_mobile
    prepare_for_mobile if mobile?
  end
  
  def mobile?
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return true if agent.match(m)
    end
    return false
  end
  
  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end
  
  def permission_denied
    flash[:error] = "You are not allowed to access that page."
    redirect_to root_url
  end
  
  def current_user_session      
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)    
    @current_user = current_user_session && current_user_session.user      
  end

  def require_user
    logger.debug "ApplicationController::require_user"
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    logger.debug "ApplicationController::require_no_user"
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
     # redirect_to home_index_path
      return false
    end
  end

  def store_location
    #session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default, options = {})
    redirect_to(session[:return_to] || default, options)
    session[:return_to] = nil
  end
  
  def user_authorized_for_jukebox?(jukebox_id)
    
    # check if user is logged in AND the owner of the jukebox to show jplayer
    # this is subject to change in the future.
    if current_user && Jukebox.find(jukebox_id).user_id == current_user.id
      return true
    else
      return false
    end
  end
  
  def user_authorized_for_jukebox_song?(jukebox_song_id)
    
    # check if user is logged in and authorized to edit the jukebox song he submitted
    # checks if the user is the owner of the jukebox song
    if current_user && JukeboxSong.find(jukebox_song_id).user_id == current_user.id
      return true
    else
      return false
    end
    
  end
  
  private
  
  # rank ranks all songs in the playlist based on votes submitted
  # rank is called after a song finishes playing, when a jukebox_song is added, 
  # a jukebox_song is deleted, when a vote is added, a vote is deleted
  def rank(jukebox_id)
    votes = Vote.arel_table
    jukebox_songs = JukeboxSong.arel_table
    
    # keep an array of arrays of size 2, with index 0 being 
    # the jukebox_song_id, index 1 being the number of votes for that jukebox_song
    vote_counts = []
    
    JukeboxSong.songs_for_jukebox(jukebox_id).each do |jukebox_song|
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
      jukebox_song = JukeboxSong.find(id)
      
      # start with 0, rank 0 is current song playing
      jukebox_song.rank = i
      
      jukebox_song.save
    end
    
    @songs = JukeboxSong.songs_for_jukebox(jukebox_id)
    
    # list ranked, publish to faye client
    faye_client.publish("/playlists/juke_" + jukebox_id.to_s, :songs => @songs)
    
  end
end