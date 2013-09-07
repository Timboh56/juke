def test_user
  user = User.find_by_username("test") || User.create!(:email => "email@email.com", :username => "test", :password => "mypassword", :password_confirmation => "mypassword")
end

FactoryGirl.define do
  factory :user do
    email "myemail@something.com"
	  username "test"
	  password "mypassword"
	  password_confirmation "mypassword"
  end
end