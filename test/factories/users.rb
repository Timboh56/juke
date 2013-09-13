def test_user
  user = User.find_by_username("test") || FactoryGirl.create(:user, :email => "email@email.com", :username => "test")
end

def new_user
  user = FactoryGirl.create(:user, :email => "email" + Random.rand(100).to_s + "@email.com", :username => "test" + Random.rand(100).to_s)
end

FactoryGirl.define do
  factory :user do
	  password "mypassword"
	  password_confirmation "mypassword"
  end
end