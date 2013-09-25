class JukeboxesController < ApplicationController
  filter_resource_access
  respond_to :xml, :html, :json
  helper_method :empty_playlist?

  def index
    if current_user
      @not_user_jukeboxes = Jukebox.not_user_jukeboxes(current_user)
      @user_jukeboxes = Jukebox.user_jukeboxes(current_user)
      respond_with(@jukeboxes)
    end
  end

  # GET /jukeboxs/1
  # GET /jukeboxs/1.json
  def show
    @jukebox = Jukebox.find(params[:id])
    @songs = @jukebox.jukebox_songs.order("rank ASC")
    
    respond_with(@jukebox)
  end

  # GET /jukeboxs/new
  # GET /jukeboxs/new.json
  def new
    @jukebox = Jukebox.new

    respond_with(@jukebox)
  end

  # GET /jukeboxs/1/edit
  def edit
    @jukebox = Jukebox.find(params[:id])
  end

  # POST /jukeboxs
  # POST /jukeboxs.json
  def create
    @jukebox = Jukebox.new(params[:jukebox])
    @jukebox.user_id = current_user.id

    respond_to do |format|
      if @jukebox.save
        format.html { redirect_to @jukebox, notice: 'Jukebox was successfully created.' }
        format.json { render json: @jukebox, status: :created, location: @jukebox }
      else
        format.html { render action: "new" }
        format.json { render json: @jukebox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jukeboxs/1
  # PUT /jukeboxs/1.json
  def update
    @jukebox = Jukebox.find(params[:id])

    respond_to do |format|
      if @jukebox.update_attributes(params[:jukebox])
        format.html { redirect_to @jukebox, notice: 'Jukebox was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jukebox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jukeboxs/1
  # DELETE /jukeboxs/1.json
  def destroy
    @jukebox = Jukebox.find(params[:id])
    @jukebox.destroy

    respond_with(@jukebox)
  end
  
  def empty_playlist?
    @jukebox = Jukebox.find(params[:id])
    return @jukebox.empty_playlist?
  end
  
  def add_song_to_jukebox
    if current_user
      jukebox_song = JukeboxSong.new(params[:jukebox_song])
      jukebox_song.jukebox_id = params[:id]
      jukebox_song.user_id = current_user.id
      respond_to do |format|
        if jukebox_song.save
        
          jukebox = Jukebox.find(jukebox_song.jukebox_id)
        
          # rank jukebox's playlist
          jukebox.rank!
          
          # publish the new playlist to faye client
          publish_to_jukebox(jukebox.id)
          
          format.json { render json: { :success => "Song added to jukebox" } }
        else
          
          # failed validation -> song has already been submitted
          
          format.json { render json: "That song has already been submitted.", status: :unprocessable_entity }
        end
      end
    end
  end
  
  def get_playlist
    @songs = JukeboxSong.songs_for_jukebox(params[:id])
    render :partial => "playlist2", :locals => { :songs => @songs }
  end
  
  # when user clicks play or the track is at an end,
  # this function is called. It first sets current_song if
  # it is not set, which indicates the current song playing.
  def next_song
    
    # check if user is authorized to do this, REFACTOR    
    jukebox = Jukebox.find(params[:id])
    
    if user_authorized_for_object?(jukebox)
      
      if !jukebox.empty_playlist?
        # sets current song if it hasn't been set yet
        current_song = jukebox.set_current_song!
      
        if params[:type] == "next" # track is at its end

          # current_song playing is done playing, delete from db
          current_song.destroy
        
          # reload jukebox, REFACTOR!!!
          jukebox = Jukebox.find(params[:id])
    
        end      
        # check again if jukebox is empty
        if !jukebox.empty_playlist?
          # rerank the jukebox's playlist
          jukebox.rank!
      
          # set current_song based on new ranking
          jukebox.set_current_song!
        end
        
        # publish new playlist to faye client
        publish_to_jukebox(jukebox.id)
          
        # find newest current_song
        current_song = Jukebox.find(params[:id]).current_song
      
        respond_to do |format|
          if current_song
            format.json { render json: current_song.song }
          else
            format.json { render json: "Couldn't find another song!", status: :unprocessable_entity }
          end
        end
      end
    end   
  end
end
