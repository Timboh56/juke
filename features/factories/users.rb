def test_user
  user = User.find_by_username("test_user") || FactoryGirl.create(:user)
end

def admin_user
  user = User.find_by_username("admin_user") || FactoryGirl.create(:user, :admin)
end

def user_role
  user = Role.find_by_name("user") || Role.create!(:id => 2, :name => "user")
end

def admin_role
  admin = Role.find_by_name("admin") || Role.create!(:id => 1, :name => "admin")
end

FactoryGirl.define do
  factory :user do
    email "myemail@something.com"
	  username "test_user"
	  password "mypassword"
	  password_confirmation "mypassword"
    
    trait :admin do
      email "admin@admin.com"
      username "admin_user"
      
      after(:create) do |o,e|
        o.roles << admin_role
        o.save!
      end
    end
  end
end