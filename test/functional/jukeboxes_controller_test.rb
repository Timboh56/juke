require 'test_helper'

class JukeboxesControllerTest < ActionController::TestCase

  setup do
    prep_objects
    UserSession.create(@user)    
  end
  
  test "get playlist" do
   get :get_playlist
  
  end
  
  test "next song" do
    
    # assign rankings automatically to jukebox_songs
    @jukebox_song1.update_attributes!(:rank => 1)
    @jukebox_song2.update_attributes!(:rank => 2)
    
    get :next_song, { :jukebox_id => @test_jukebox.id }
    
    # look for the deleted jukebox_song
    result = JukeboxSong.where(:id => @jukebox_song1.id)
    
    # assert nothing to be found from the result
    assert_empty(result)
    
  end
  
  test "next song with two songs with same number of votes" do
    
    # assign rankings automatically to jukebox_songs
    @jukebox_song1.votes << FactoryGirl.create(:vote)
    @jukebox_song2.votes << FactoryGirl.create(:vote)
    
    get :next_song, { :jukebox_id => @test_jukebox.id }
    
    # look for the deleted jukebox_song
    result = JukeboxSong.where(:id => @jukebox_song1.id)
    
    # assert nothing to be found from the result
    assert_empty(result)
    
  end
end