var playlist = {
	init: function(jplayer_div_id, jukebox_id, client){
		
		// class variables
		var self = this;

		this.client = client;
		this.current_song;
		this.jukebox_id = jukebox_id;
		this.jplayer_div_id = jplayer_div_id;
		
		var track = this.get_next_track();
	},
	
	get_playlist: function(){

		// get the updated playlist
		$.ajax({
			type: "GET",
			dataType: "html",
			data: { jukebox_id: this.jukebox_id },
			url: "/get_playlist",
			success: function(data){
				$(".playlist").html(data);
			}
		});
	},
	
	add_track_to_playlist: function(track){
  
	},
	
	get_next_track: function(){
		var self = this;
		
		$.ajax({
			type: "GET",
			dataType: "json",
			data: { jukebox_id: this.jukebox_id },
			url: "/next_song",
			success: function(data){
				self.current_song = data;
			}
		});
		
	},
	
	jsplayer: function(){
		var self = this;
		
		// everytime a song completes, or jukebox owner starts playing the playlist
		// 1. get reranked playlist
		// 2. send current song (highest rank) url to front end for processing
		// 3. use jplayer to detect when song completes, or if that's not possible, make a bootleg timer
		// 4.when song completes, repeat until no songs are left in playlist.
	
		this.client.subscribe("playlists/juke_" + this.jukebox_id, function(data){
		
	
		});
		
		$("#" + self.jplayer_div_id).jPlayer({
			ready: function (event){
				$(this).jPlayer("setMedia", {
					mp3: "/tunes/" + self.current_song.url
				});
			},
			swfPath: "js",
			supplied: "mp3",
			wmode: "window",
			smoothPlayBar: true,
			keyEnabled:true,
			ended: function(){
				self.get_next_track();
			    $(this).jPlayer("play");
			}
		});
	}
};
