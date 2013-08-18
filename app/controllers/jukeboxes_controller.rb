class JukeboxesController < ApplicationController
  filter_resource_access

  def index
    @bars = Jukebox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bars }
    end
  end

  # GET /bars/1
  # GET /bars/1.json
  def show
    @bar = Jukebox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bar }
    end
  end

  # GET /bars/new
  # GET /bars/new.json
  def new
    @bar = Jukebox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bar }
    end
  end

  # GET /bars/1/edit
  def edit
    @bar = Jukebox.find(params[:id])
  end

  # POST /bars
  # POST /bars.json
  def create
    @bar = Jukebox.new(params[:bar])

    respond_to do |format|
      if @bar.save
        format.html { redirect_to @bar, notice: 'Jukebox was successfully created.' }
        format.json { render json: @bar, status: :created, location: @bar }
      else
        format.html { render action: "new" }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bars/1
  # PUT /bars/1.json
  def update
    @bar = Jukebox.find(params[:id])

    respond_to do |format|
      if @bar.update_attributes(params[:bar])
        format.html { redirect_to @bar, notice: 'Jukebox was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1
  # DELETE /bars/1.json
  def destroy
    @bar = Jukebox.find(params[:id])
    @bar.destroy

    respond_to do |format|
      format.html { redirect_to bars_url }
      format.json { head :no_content }
    end
  end
end
