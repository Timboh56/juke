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

Given(/^I am at the (.+)$/) do |page|
  log_in(test_user)
  visit path_to(page)
end

When(/^I go the the (.+)$/) do |page|
  visit path_to(page)
end

When(/^I downvote a listed song$/) do
end

When(/^I upvote a listed song$/) do
end

When(/^I fill in fields for "(.*?)" as the song title and "(.*?)" for the artist$/) do |song_title, artist|
  fill_in('Song title',:with => song_title)
  fill_in('Artist',:with => artist)
end

When(/^I click "(.*?)"$/) do |button_name|
  click_button(button_name)
end

Then(/^I should get a (\d+) response$/) do |http_code|
  Capybara.default_wait_time = 5
  page.status_code.should == 200
end

Then(/^I should see "([^\"]*)"$/) do |text|
  page.status_code.should == 200
  page.should have_content(text)
end

Then(/^I should have another vote for the song$/) do
end

Then(/^I should have destroyed a vote for the song$/) do
end

Then(/^the song should have one less vote$/) do
end