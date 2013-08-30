class JukeboxSongsController < ApplicationController
  def search_for_songs
    @search = Song.search do
      fulltext params[:search]
    end
        
    @results = @search.results
    
    respond_to do |format|
      format.html { render :partial => "jukeboxes/search_results", :locals => { :results => @results }}
    end
  end
  
  # rerank ranks all songs in the playlist based on votes submitted
  def rerank(jukebox_id)
    votes = Vote.arel_table
    jukebox_songs = JukeboxSong.arel_tabl
    Vote.jukebox_votes(jukebox_id).count
    
  end
  
  def upvote
    jukebox_songs = JukeboxSong.arel_table
    
    # create new vote for the jukebox_song
    vote = Vote.new(params[:vote])
    vote.user_id = current_user.id
    
    respond_to do |format|
    
      if vote.save!    
        # increment the count number for the vote's jukebox_song
        votes_jukebox_song = JukeboxSong.where(jukebox_songs[:id].eq(params[:vote][:jukebox_song_id])).first
        votes_jukebox_song.votes_count = votes_jukebox_song.votes_count + 1
        votes_jukebox_song.save!
        format.json { render :json => { :votes_jukebox_song_count => votes_jukebox_song.votes_count } }
      else
        format.json { render :json => { :error => "You have already submitted a vote. " } }
      end
    end
  end
end
