def test_song_name
  song = "My Song " + rand(10).to_s
end

FactoryGirl.define do
  factory :vote do
    user test_user
	  jukebox test_jukebox
    song_title test_song_name
  end
end