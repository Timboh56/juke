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
    
    # create test songs
    @test_song1 = FactoryGirl.create(:song, :name => "test song 1")
    
    @test_song2 =  FactoryGirl.create(:song, :name => "test song 2")
    
    @test_song3 =  FactoryGirl.create(:song, :name => "test song 3")
          
    @jukebox_song1 = test_jukebox_song(@test_jukebox.id, @test_song1.id)
    
    @jukebox_song2 = test_jukebox_song(@test_jukebox.id, @test_song2.id)
    
    @jukebox_song3 = test_jukebox_song(@test_jukebox.id, @test_song3.id)
    
    
  end
  
  def setup_votes
    
    # clear votes
    Vote.delete_all
    
    # jukebox_song1 should have 3 total votes
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user2)
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user3)
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user)
    
    
    # jukebox_song2 should have 2 total votes
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song2, :user => @user2)
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song2, :user => @user3)
    
    # jukebox_song3 should have just 1 vote
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song3, :user => @user)
    
  end

  def setup_votes_same_vote_count
    
    Vote.delete_all
    
    # each jukebox_song has 1 vote
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song1, :user => @user2)
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song2, :user => @user2)
    FactoryGirl.create(:vote, :jukebox_song => @jukebox_song3, :user => @user)

  end
  
end
