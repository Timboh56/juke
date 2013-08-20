Given(/^I have a bunch of songs in the form of votes$/) do
  Vote.delete_all
  User.delete_all
  song1 = FactoryGirl.create!(:vote)
  song2 = FactoryGirl.create!(:vote)
  song3 = FactoryGirl.create!(:vote)
end

When(/^I go the the (.+)$/) do |page|
  visit path_to(page)
end

Then(/^I should see the songs$/) do
end

Given(/^I have a list of votes$/) do
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
