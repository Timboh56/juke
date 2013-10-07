require 'test_helper'

class JukeboxesControllerTest < ActionController::TestCase

  setup do
    prep_objects
    UserSession.create(@user)    
  end
  
  test "get playlist" do
   get :get_playlist, { :id => @test_jukebox.id }
  
  end
  
  test "next song initialize" do    
    setup_votes
    
    get :next_song, { :id => @test_jukebox.id, :type => "init" }
    
    result = JukeboxSong.find(@jukebox_song1.id)
    
    assert_equal(result.playing,true)
  end
  
  test "next song" do
    
    setup_votes
    
    # should rank, then delete current song
    get :next_song, { :id => @test_jukebox.id, :type => "next" }
    
    # look for the deleted jukebox_song
    result = JukeboxSong.where(:id => @jukebox_song1.id)
    
    # assert nothing to be found from the result
    assert_empty(result)
    
  end
  
  test "next song with two songs with same number of votes" do
    
    setup_votes_same_vote_count
    
    get :next_song, { :id => @test_jukebox.id, :type => "next"  }
    
    # look for the deleted jukebox_song
    result = JukeboxSong.where(:id => @jukebox_song3.id)
    
    # assert nothing to be found from the result
    assert_empty(result)
    
  end
end