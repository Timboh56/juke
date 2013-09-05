class JukeboxesController < ApplicationController
  # filter_resource_access
  respond_to :xml, :html, :json

  def index
    @jukeboxes = Jukebox.all

    respond_with(@jukeboxes)
  end

  # GET /jukeboxs/1
  # GET /jukeboxs/1.json
  def show    
    @jukebox = Jukebox.find(params[:id])
    
    @song = Song.new
    @songs = @jukebox.jukebox_songs
    
    # get the highest rank song (current song playing)
    @current_song = @songs.first
    
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
  
  def get_playlist
    @songs = JukeboxSong.where(:jukebox_id => params[:jukebox_id])
    render :partial => "playlist2", :locals => { :songs => @songs }
  end
  
  def next_song
    @songs = JukeboxSong.where(:jukebox_id => params[:jukebox_id])
    
    # get the next highest rank song (current song playing)
    @current_song = @songs.first
    
    # TODO: CHANGE TO MORE EFFECTIVE AUTHORIZATION 
    if current_user && current_user.user_authorized_for_jukebox?(params[:jukebox_id])
  
      # current_song playing is done playing, delete from db
      @songs.first.destroy!
  
    end
    
    @current_song = @songs.first.song
  
    respond_to do |format|
      format.json { render json: @current_song }
    end      
      
  end 
end
