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
  
  def upvote
    
    # create new vote for the jukebox_song
    vote = Vote.new(params[:vote])
    vote.user_id = current_user.id
    
    respond_to do |format|
    
      if vote.save
        votes_jukebox_song = JukeboxSong.find(params[:vote][:jukebox_song_id])
        jukebox = Jukebox.find(vote.jukebox_id)
        jukebox.rank!
        
        # publish the new playlist to faye client
        publish_to_jukebox(jukebox.id)
    
        format.json { render :json => { :votes_jukebox_song_count => votes_jukebox_song.votes_count } }
      else
        format.json { render json: "Vote already submitted.", status: :unprocessable_entity }
      end
    end
  end
  
  def downvote
    jukebox_songs = JukeboxSong.arel_table
    
    # create new vote for the jukebox_song
    vote = Vote.user_votes(current_user).where(:jukebox_song_id => params[:vote][:jukebox_song_id]).first
        
    respond_to do |format|    
      if vote
        vote.destroy
        jukebox = Jukebox.find(vote.jukebox_id)
        jukebox.rank!
        
        # publish the new playlist to faye client
        publish_to_jukebox(vote.jukebox_id)
            
        votes_jukebox_song = JukeboxSong.find(params[:vote][:jukebox_song_id])
        
        format.json { render :json => { :votes_jukebox_song_count => votes_jukebox_song.votes_count } }
      else
        format.json { render json: "An error occured" }
        
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