def test_jukebox_song(jukebox_id, song_id)
  jukebox_song ||= FactoryGirl.create(:jukebox_song, :jukebox_id => jukebox_id, :song_id => song_id)
end

FactoryGirl.define do
  factory :jukebox_song do
    user { test_user }
  end
end