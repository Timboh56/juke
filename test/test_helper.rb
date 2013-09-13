ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "authlogic/test_case"


class ActiveSupport::TestCase
  setup :activate_authlogic
  

  # Add more helper methods to be used by all tests here...
  
  def prep_objects    
    
    # clear out tables
    [Role, Jukebox, JukeboxSong, User, Vote, Song].each{|k| k.delete_all}

    # create roles
    Role.create(:name => "user")
    Role.create(:name => "admin")
        
    # create test user
    @user = test_user
    @user2 = new_user
    @user3 = new_user
    
        
    # create test jukebox
    @test_jukebox = test_jukebox
    
    # create test song
    @test_song1 = FactoryGirl.create(:song, :name => "test song 1")
    
    @test_song2 =  FactoryGirl.create(:song, :name => "test song 2")
        
    @jukebox_song1 = test_jukebox_song(@test_jukebox.id, @test_song1.id)
    
    @jukebox_song2 = test_jukebox_song(@test_jukebox.id, @test_song2.id)
    
    @test_vote = FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user2)
    @test_vote2 = FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user3)
    @test_vote3 = FactoryGirl.create(:vote, :jukebox_song => @jukebox_song2, :user => @user2)
    
  end
  
end
