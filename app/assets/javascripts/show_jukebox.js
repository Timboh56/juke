$(function(){
	var UPDATE_INTERVAL = 1000;
	
	// get container from DOM
	var container = $(".container");
	
	// get ID of jukebox from jukebox_header
	var id = container.find(".jukebox_header").attr("id");
	
	var last_song_id = container.find(".song").last()
	
	// update playlist every few seconds dynamically
	setInterval(function() {
		$.ajax({
			type: "GET",
			dataType: "jsonp",
			data: { jukebox_id: id },
			url: "/get_playlist",
			complete: function(resp) {
				$("<div class=\"song\">" + resp)
				$(".playlist .song").last().append(resp);
			}
		});
	}, UPDATE_INTERVAL);
	
	// handle song submission functionality
	$(".add_song").on("click",function() {
		// get song artist field
		var song_artist = container.find("#vote_artist").val();
	
		// get song title field
		var song_title = container.find("#vote_song_title").val();
		
		$.ajax({
			type: "PUT",
			dataType: "jsonp",
			data: { vote: { artist: song_artist, song_title: song_title, jukebox_id: id } },
			url: "/add_song_for_playlist",
		});
	});
});