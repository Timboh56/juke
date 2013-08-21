Given(/^I have a list of votes$/) do
  Vote.delete_all
  User.delete_all
  song1 = FactoryGirl.create!(:vote)
  song2 = FactoryGirl.create!(:vote)
  song3 = FactoryGirl.create!(:vote)
end

Given(/^I have a playlist containing "(.*?)"$/) do |song_title|
  @song4 = FactoryGirl.create(:vote, :song_title => song_title, :artist => "Beatles")
end

When(/^I go the the (.+)$/) do |page|
  visit path_to(page)
end

Then(/^I should see "([^\"]*)"$/) do |text|
  log_in(test_user)  
  page.should have_content(text)
end


When(/^I upvote a listed song$/) do
end

Then(/^I should have another vote for the song$/) do
end

When(/^I downvote a listed song$/) do
end

Then(/^I should have destroyed a vote for the song$/) do
end

Then(/^the song should have one less vote$/) do
end
