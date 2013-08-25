class JukeboxesController < ApplicationController
  # filter_resource_access
  respond_to :xml, :html, :json
  before_filter(:faye_client)
  
  def faye_client
    faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end

  def index
    @jukeboxes = Jukebox.all

    respond_with(@jukeboxes)
  end

  # GET /jukeboxs/1
  # GET /jukeboxs/1.json
  def show    
    @jukebox = Jukebox.find(params[:id])
    @vote = Vote.new
    @songs = @jukebox.votes
    respond_with(@jukebox)
  end
  
  def add_song_for_playlist
    @v = Vote.new(params[:vote])
    @v.user_id = current_user.id
    
    respond_to do |format|
      if @v.save
        faye_client.publish('/playlists/juke_' + @v.jukebox_id.to_s, :song_title => @v.song_title, :artist => @v.artist)
        format.json { render :nothing => true }
      else
        format.html { render :partial => "layouts/error_messages", :locals => { :target => @v }}
      end
    end
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
end
