Feature: Manage Votes
  In order to make a playlist of songs
  As an user
  I want to create and manage my songs for the jukebox
  
  Scenario: Votes List
    Given I have a playlist containing "Hey Jude"
	  When I go the the jukebox page
	  Then I should see "Hey Jude"
	
  Scenario: Upvoting
    Given I have a list of votes
	  When I upvote a listed song
	  Then I should have another vote for the song
	
  Scenario: Upvoting
    Given I have a list of votes
  	When I downvote a listed song
  	Then I should have destroyed a vote for the song
	  And the song should have one less vote