class JukeboxSongsController < ApplicationController
  respond_to :xml, :html, :json
  
  def search_for_songs
    @search = Song.search do
      fulltext params[:search]
    end
        
    @results = @search.results
    
    respond_to do |format|
      format.html { render :partial => "jukeboxes/search_results", :locals => { :results => @results }}
    end
  end
  
  def add_song_to_jukebox
    if current_user
      jks = JukeboxSong.new(params[:jukebox_song])
      jks.user_id = current_user.id
      jks.save!
      
      # rank jukebox's playlist
      rank(jks.jukebox_id)
      
      faye_client.publish("playlists/juke_" + jks.jukebox_id.to_s, 'text' => "hello world")
      
      @songs = JukeboxSong.songs_for_jukebox(params[:jukebox_song][:jukebox_id])
            
      respond_to do |format|
        format.html {render :partial => "jukeboxes/playlist2", :locals => {:songs => @songs}}
      end
    end
    
  end
  
  def upvote
    jukebox_songs = JukeboxSong.arel_table
    
    # create new vote for the jukebox_song
    vote = Vote.new(params[:vote])
    vote.user_id = current_user.id
    
    respond_to do |format|
    
      if vote.save!    
        votes_jukebox_song = JukeboxSong.find(params[:vote][:jukebox_song_id])
        rank(vote.jukebox_id)
        format.json { render :json => { :votes_jukebox_song_count => votes_jukebox_song.votes_count } }
      else
        format.json { render :json => { :error => "You have already submitted a vote. " } }
      end
    end
    
    
  end
  
  def downvote
    jukebox_songs = JukeboxSong.arel_table
    
    # create new vote for the jukebox_song
    vote = Vote.user_votes(current_user)
        
    respond_to do |format|    
      vote = vote.where(:jukebox_song_id => params[:vote][:jukebox_song_id]).first
      if vote
        vote.destroy
        rank(vote.jukebox_id)        
        votes_jukebox_song = JukeboxSong.find(params[:vote][:jukebox_song_id])
        
        format.json { render :json => { :votes_jukebox_song_count => votes_jukebox_song.votes_count } }
      end
    end
  end
  
  # DELETE /jukeboxs/1
  # DELETE /jukeboxs/1.json
  def destroy
    @jukebox_song = JukeboxSong.find(params[:id])
    jukebox_id = @jukebox_song.jukebox_id
    @jukebox_song.destroy
    
    @songs = JukeboxSong.songs_for_jukebox(jukebox_id)
    
    respond_to do |format|
      format.html {render :partial => "jukeboxes/playlist2", :locals => {:songs => @songs}}
    end
  end
  
end
