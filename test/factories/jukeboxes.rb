def test_jukebox
  jukebox = Jukebox.find_by_name("test_jukebox") || FactoryGirl.create(:jukebox)
end

FactoryGirl.define do
  factory :jukebox do
    name "test_jukebox"
    user { test_user }
  end
end