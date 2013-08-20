def test_user
  user ||= FactoryGirl.create(:user)
end

FactoryGirl.define do
  factory :user do
    email "myemail@something.com"
	  username "test"
	  password "mypassword"
	  password_confirmation "mypassword"
  end
end