var playlist = {
	init: function(jplayer_div_id, jp_container, jukebox_id, client){
		
		this.NO_SONG_MSG = "Ain't got nothing har.";

		this.options = {};
		
		this.client = client;
		this.current_song;
		this.jukebox_id = jukebox_id;
		this.jplayer_div_id = jplayer_div_id;
		this.jp_container = jp_container;
		this.container = $(jp_container);
		this.initialized = false;
		
		var self = this;
		
		var dfd = $.Deferred();
		
		// check if playlist is empty
		this.init_jsplayer();
		
		// move to playlist module
		this.container.on("click",".jp-play", function(event){
			event.preventDefault();
			
			// get the first song
			// if success, start playing it
			self.get_next_song("init").done(function(){
				self.add_and_play_current_song();
			});
		});
		
	},
	
	get_playlist: function(){
		var self = this;
		
		// get the updated playlist
		$.ajax({
			type: "GET",
			dataType: "html",
			data: { jukebox_id: self.jukebox_id},
			url: "/get_playlist",
			success: function(data){
				$(".playlist").html(data);
			}
		});
	},

	get_next_song: function(type){
		var self = this;
		var dfd = $.Deferred();
		
		$.ajax({
			type: "GET",
			dataType: "json",
			data: { jukebox_id: this.jukebox_id, type: type },
			url: "/next_song",
			success: function(data){
				self.current_song = data;
				dfd.resolve();
			},
			error: function(){
				dfd.reject();
			}
		});
		
		return dfd.promise();
	},
	
	init_jsplayer: function(){
		var self = this;
		
		// everytime a song completes, or jukebox owner starts playing the playlist
		// 1. get reranked playlist
		// 2. send current song (highest rank) url to front end for processing
		// 3. use jplayer to detect when song completes, or if that's not possible, make a bootleg timer
		// 4.when song completes, repeat until no songs are left in playlist.
	
		self.playlist = new jPlayerPlaylist({
			jPlayer: "#" + self.jplayer_div_id,
			cssSelectorAncestor: self.jp_container
		}, [],
		{
			playlistOptions: {
				enableRemoveControls: true
			},
			swfPath: "js",
			supplied: "webmv, ogv, m4v, oga, mp3",
			smoothPlayBar: true,
			keyEnabled: true,
			audioFullScreen: true,
			ended: function(){
				var jplayer_div = this;
						
				// call get_next_song, which sets current_song
				self.get_next_song("next")
					.done(function(){		
						self.playlist.remove(0);
						self.add_and_play_current_song();
					})
					.fail(function(){
						self.finish();
					});
				}
			}
		); 
	},
	
	add_and_play_current_song: function(){
		var self = this;
		
		// set header on jplayer to current song name and artist
		// REFACTOR TO SOMETHING LESS UGLY
		var html = $("<h2>").html(self.current_song.name + " by " + self.current_song.artist);
		self.container.find(".current_song").html(html);
		
		// update the page's playlist for any changes
		self.get_playlist();
		
		// add current_song to jPlaylist for jplayer
		self.playlist.add({
			title: self.current_song.name,
			artist: self.current_song.artist,
			mp3: "/tunes/" + self.current_song.url	// TO-DO: CHANGE TO MORE DYNAMIC FORMAT
		}, true);
		
		self.playlist.play();
	},
	
	finish: function(){
		this.initialized = false;
		this.container.html(this.NO_SONG_MSG);
	},
		
	flash_Error_Messages: function(message){
		var self = this;
		
		// make playlist errors reappear.
		self.container.find(".error").fadeIn(1000);
		self.container.find(".error").html(message);
		setTimeout(function(){
			self.container.find(".error").fadeOut(1000);
		},9000);
	}
};