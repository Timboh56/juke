var playlist_func = {};

var tracks = [];
var current_song_index = 0;

var init_jplayer = function(id){
	var self = this;
	var track = get_next_track();
	
	$("#" + id).jPlayer({
		ready: function (event){
			$(this).jPlayer("setMedia", {
				mp3: "home.mp3"
			});
		},
		swfPath: "js",
		supplied: "mp3",
		wmode: "window",
		smoothPlayBar: true,
		keyEnabled:true,
		ended: function(){
			self.track = get_next_track();
		    $(this).jPlayer("play");
		}
	});
}

var add_track_to_playlist = function(track){
  
}

var get_next_track = function(){
	return tracks[current_song_index];
	current_song_index++;
}

var jsplayer = function(client,id){
	
	// everytime a song completes, or jukebox owner starts playing the playlist
	// 1. get reranked playlist
	// 2. send current song (highest rank) url to front end for processing
	// 3. use jplayer to detect when song completes, or if that's not possible, make a bootleg timer
	// 4.when song completes, repeat until no songs are left in playlist.
	
	client.subscribe("playlists/juke_" + id, function(data){
		
	
	});
}