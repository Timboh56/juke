require 'test_helper'

class JukeboxesControllerTest < ActionController::TestCase

  setup do
    
  
  end
  
  test "test get playlist" do
    @jukeboxes = JukeboxesController.new
    @jukeboxes.instance_eval{ get_playlist }
  
  end
  
end