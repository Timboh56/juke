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
end
