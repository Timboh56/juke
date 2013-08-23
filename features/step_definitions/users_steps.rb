Given(/^I am the test_user$/) do
  @user = test_user  
end

Given(/^I am the admin_user$/) do
  @user = admin_user
end

Given(/^I am on the (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I login$/) do
  fill_in('Username', :with => @user.username)
  fill_in('Password', :with => "mypassword")
  click_button('Login')
end

Then(/^I should be redirected to "(.*?)"$/) do |page_name|
  page.current_path.should == path_to(page_name)
end