class JukeboxesController < ApplicationController
  # filter_resource_access
  respond_to :xml, :html, :json
  helper_method :empty_playlist?

  def index
    @jukeboxes = Jukebox.all

    respond_with(@jukeboxes)
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
    return @jukebox.jukebox_songs.empty?
  end
  
  def get_playlist
    @songs = JukeboxSong.songs_for_jukebox(params[:jukebox_id])
    render :partial => "playlist2", :locals => { :songs => @songs }
  end
  
  # sets the highest ranked song as the currently played song
  # executed when user hits play on jplayer
  def set_current_song
    
    jukebox = Jukebox.find(params[:jukebox_id])
    
    respond_to do |format|
    
      if !jukebox.empty?
        
        begin
          
          # make sure songs in jukebox are all ranked
          # to-do: add ranked boolean column in jukebox table after each ranking
          # to determine if jukebox songs of jukebox are already ranked
          # instead of having to see if each jukebox_song has a number assigned for ranking
          # if not ranked, rank
          rank(params[:jukebox_id]) # if !jukebox.ranked?
    
          jukebox.set_current_song!
          current_song = jukebox.current_song
          format.json { render json: current_song.song }
        rescue
          format.json { render json: "An error occurred", status: :unprocessable_entity }
        end
      else
        format.json { render json: "You haven't added any songs.", status: :unprocessable_entity }
      end
    end
  end
  
  def next_song
    
    jukebox = Jukebox.find(params[:jukebox_id])
    
    if params[:type] == "next"
      
      if user_authorized_for_jukebox?(params[:jukebox_id])
        
        # REFACTOR
        current_song = jukebox.current_song 
        puts "deletssen"
        # current_song playing is done playing, delete from db
        current_song.destroy
  
      end      
    end
        
    rank(params[:jukebox_id])
    
    # find newest current_song
    current_song = Jukebox.find(params[:jukebox_id]).current_song
      
    respond_to do |format|
      if current_song
        format.json { render json: current_song.song }
      else
        format.json { render json: "An error occurred!", status: :unprocessable_entity }
      end
    end      
      
  end 
end
