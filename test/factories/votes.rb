def test_song_name
  song = "My Song " + rand(10).to_s
end

FactoryGirl.define do
  factory :vote do
	  jukebox {test_jukebox}
  end
end