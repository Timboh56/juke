var playlist = {
	init: function(jplayer_div_id, jp_container, jukebox_id, client){
		
		// class variables
		var self = this;

		this.options = {};
		
		this.client = client;
		this.current_song;
		this.jukebox_id = jukebox_id;
		this.jplayer_div_id = jplayer_div_id;
		this.jp_container = jp_container;
		
		var self = this;
		
		var dfd = $.Deferred();
		
		self.get_first_song().done(function(){
			self.init_jsplayer();
		}).fail(function(){
			$("#" + self.jplayer_div_id).html("Ain't got nothing har.");
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
				alert("done no partial content");
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
	
		var html = $("<h2>").html(self.current_song.name + " by " + self.current_song.artist);
		$(".current_song").html(html);
		self.playlist = new jPlayerPlaylist({
			jPlayer: "#" + self.jplayer_div_id,
			cssSelectorAncestor: "#" + self.jp_container
		}, [{
				title: self.current_song.name,
				artist: self.current_song.artist,
				mp3: "/tunes/" + self.current_song.url	// TO-DO: CHANGE TO MORE DYNAMIC FORMAT
			}],
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
					  self.get_next_song().done(function(){
						var html = $("<h2>").html(self.current_song.name + " by " + self.current_song.artist);
						$(".current_song").html(html);
						self.get_playlist();	
						self.playlist.add({
							title: self.current_song.name,
							artist: self.current_song.artist,
							mp3: "/tunes/" + self.current_song.url	// TO-DO: CHANGE TO MORE DYNAMIC FORMAT
						}, true);
						playlist.remove(0);
						self.play();
					});
				}
			}
		); 
		
		self.play();
	},
	play: function(){
		this.playlist.play();
	}
};
