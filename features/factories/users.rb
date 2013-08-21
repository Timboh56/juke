def test_user
  user = User.find_by_username("test_user") || FactoryGirl.create(:user)
end

def test_role
  # clear everything
  user ||= Role.create!(:id => 2, :name => "user")
end

FactoryGirl.define do
  factory :user do
    email "myemail@something.com"
	  username "test_user"
	  password "mypassword"
	  password_confirmation "mypassword"
    
    after(:create) do |o,e|
      e.roles << test_role
    end
  end
end