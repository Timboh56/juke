def test_song_name
  song = "My Song " + rand(10).to_s
end

FactoryGirl.define
  factory :vote do
    user test_user
	  jukebox testJukebox
    song_title test_song_name
  end
end