require 'test_helper'

class JukeboxSongsControllerTest < ActionController::TestCase

  setup do
    
  
  end
  
  test "test rerank" do
    @jukebox_songs = JukeboxSongsController.new
    @jukebox_songs.instance_eval{ rerank }
  
  end
  
end