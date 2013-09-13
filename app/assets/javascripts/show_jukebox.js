var client = new Faye.Client("http://localhost:9292/faye");

$(function(){
	var UPDATE_PLAYLIST_INTERVAL = 4000;
	
	// get container from DOM
	var container = $(".container");
	
	// get ID of jukebox from jukebox_header
	var jukebox_id = container.find(".jukebox_header").attr("id");
	
	var chatroom = container.find(".chat_room");
		
	var username = chatroom.attr("data-username");
		
    var height = chatroom.height();	
	var msgs = 0;
	
	playlist.init("jquery_jplayer_1", "jp_container_1", jukebox_id, client);
		
	// SUBSCRIPTIONS
	
    // Subscribe to the jukebox chatroom channel
    var chat_sub = client.subscribe("/chats/juke_" + jukebox_id, function(data) {
	  msgs++;
	  chatroom.animate({ scrollTop: msgs*height },"50");
      $("<div class=\"message\">").html(data.username + ": " + data.msg).appendTo(chatroom);
    });
		
	// subscribe to updates to the jukebox's playlist
	client.subscribe("/playlists/juke_" + jukebox_id, function(data){
		playlist.get_playlist();
	});
	
	// EVENT HANDLERS
	
	container.on("click", ".result_action", function(){
		var song_id = $(this).attr("data");
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { jukebox_song: {jukebox_id: jukebox_id, song_id: song_id} },
			url: "/add_song_to_jukebox",
			error: function(data){
				alert(data.responseText);
								// make playlist errors reappear.
				container.find(".error").fadeIn(1000);
				container.find(".error").html(data.responseText);
				setTimeout(function(){
					container.find(".error").fadeOut(1000);
				},9000);	
			}
		});
	});
	
	// handle song submission functionality
	container.on("click",".search_song",function(e) {
		e.preventDefault();
		// get song artist field
		var search = container.find("#search").val();

		$.ajax({
			type: "GET",
			dataType: "html",
			data: { search: search, jukebox_id: jukebox_id },
			url: "/search_for_songs",
			complete: function(data) {
				$("#results_list").html(data.responseText);
			}
		});
	});
	
    // Handle form submissions and post messages to faye
    container.find("#new_message_form").submit(function(event) {
		event.preventDefault();
      // Publish the message to the public channel
      client.publish("/chats/juke_" + jukebox_id, {
        username: username,
        msg: $("#message").val()
      });
	   
      // Clear the message box
      container.find("#message").val("");
 
      // Don"t actually submit the form, otherwise the page will refresh.
      return false;
    });
	
	// move to playlist module
	container.on("click", ".delete_jukebox_song", function(e){
		e.preventDefault();
		var jukebox_song_id = container.find(this).attr("data");
		$.ajax({
			type: "POST",
			dataType: "html",
			data: { _method: "delete" },
			url: "/jukebox_songs/" + jukebox_song_id,
			success: function(data){
				container.find(".playlist").html(data);
			}
		});
	});
	
	// move to playlist module
	container.on("click", ".upvote_action", function(){
		var jukebox_song_id = container.find(this).attr("data-jukebox-song");
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { vote: { jukebox_id: jukebox_id, jukebox_song_id: jukebox_song_id } },
			url: "/upvote",
			success: function(data) {
				container.find("#" + jukebox_song_id + " .jukebox_song_vote_count ").html(data.votes_jukebox_song_count);
			},
			error: function(data) {
				flash_Error_Messages(data.responseText);
			}
		});
		
	});
	
	// move to playlist module
	container.on("click", ".downvote_action", function(){
		var jukebox_song_id = container.find(this).attr("data-jukebox-song");

		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { vote: { jukebox_id: jukebox_id, jukebox_song_id: jukebox_song_id } },
			url: "/downvote",
			success: function(data) {
				container.find("#" + jukebox_song_id + " .jukebox_song_vote_count ").html(data.votes_jukebox_song_count);
			},
			error: function(data) {
				flash_Error_Messages("You already downvoted this");
			}
		});
	});
	
	
	// move to playlist module
	container.on("click",".jp-play", function(event){
		event.preventDefault();
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { jukebox_id: jukebox_id },
			url: "/set_current_song",
			success: function(data){
				// play song
				self.playlist.play();
			},
			error: function(data){
				flash_Error_Messages(data.responseText);
			}
		});
	});
	
	function flash_Error_Messages(message){
		// make playlist errors reappear.
		container.find(".error").fadeIn(1000);
		container.find(".error").html(message);
		setTimeout(function(){
			container.find(".error").fadeOut(1000);
		},9000);
	}
});