var playlist = {
	init: function(jplayer_div_id, jukebox_id, client){
		
		// class variables
		var self = this;

		this.client = client;
		this.current_song;
		this.jukebox_id = jukebox_id;
		this.jplayer_div_id = jplayer_div_id;
		
		var self = this;
		
		var dfd = $.Deferred();
		
		self.get_first_song().done(self.get_first_song.call(self), function(){
			self.jsplayer();
		});
		
	},
	
	get_first_song: function(){	
		var self = this;
		var dfd = $.Deferred();
		$.ajax({
			type: "GET",
			dataType: "json",
			data: { jukebox_id: self.jukebox_id, type: "init" },
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

	get_next_song: function(){
		var self = this;
		var dfd = $.Deferred();
		
		$.ajax({
			type: "GET",
			dataType: "json",
			data: { jukebox_id: this.jukebox_id, type: "next" },
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
	
	jsplayer: function(){
		var self = this;
		
		// everytime a song completes, or jukebox owner starts playing the playlist
		// 1. get reranked playlist
		// 2. send current song (highest rank) url to front end for processing
		// 3. use jplayer to detect when song completes, or if that's not possible, make a bootleg timer
		// 4.when song completes, repeat until no songs are left in playlist.
	
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
			    var jplayer_div = this;
				self.get_next_song().done(function(){
					self.jsplayer();
				});
			}
		});
		
		$("#" + self.jplayer_div_id).jPlayer("play");
	}
};
