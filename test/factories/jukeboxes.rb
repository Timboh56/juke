def testJukebox
  jukebox ||= FactoryGirl.create(:jukebox)
end

FactoryGirl.define
  factory :jukebox do
    name "test_jukebox"
  end
end