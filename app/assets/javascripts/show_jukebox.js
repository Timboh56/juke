var client = new Faye.Client("http://localhost:9292/faye");

$(function(){
	var UPDATE_PLAYLIST_INTERVAL = 4000;
	
	// get container from DOM
	var container = $(".container");
	
	// get ID of jukebox from jukebox_header
	var jukebox_id = container.find(".jukebox_header").attr("id");
		
	var username = container.find(".chat_room").attr("data-username");
	
    // Create a new client to connect to Faye
    var height = $(".chat_room").height();	
	var msgs = 0;
	
	playlist.init("jquery_jplayer_1", jukebox_id, client);
	
	playlist.jsplayer();
	
	// SUBSCRIPTIONS
	
    // Subscribe to the jukebox chatroom channel
    var chat_sub = client.subscribe("/chats/juke_" + jukebox_id, function(data) {
	  msgs++;
	  container.find(".chat_room").animate({ scrollTop: msgs*height },"50");
      $("<div class=\"message\">").html(data.username + ": " + data.msg).appendTo(".chat_room");
    });
		
	// subscribe to updates to the jukebox's playlist
	client.subscribe("/update/juke_" + jukebox_id, function(data){
		playlist.get_playlist();
	});
	
	// EVENT HANDLERS
	
	container.on("click", ".result_action", function(){
		var song_id = $(this).attr("data");
		$.ajax({
			type: "PUT",
			dataType: "html",
			data: { jukebox_song: {jukebox_id: jukebox_id, song_id: song_id} },
			url: "/add_song_to_jukebox",
			success: function(msg) {
				container.find(".playlist").html(msg);
			},		
			error: function(msg){
				// make playlist errors reappear.
				container.find(".error").fadeIn(1000);
				container.find(".error").html("You already submitted that!");
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
	
	container.on("click", ".upvote_action", function(){
		var jukebox_song_id = container.find(this).attr("data-jukebox-song");
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { vote: { jukebox_id: jukebox_id, jukebox_song_id: jukebox_song_id } },
			url: "/upvote",
			success: function(data) {
				client.publish("/update/juke_" + jukebox_id, data);
				container.find("#" + jukebox_song_id + " .jukebox_song_vote_count ").html(data.votes_jukebox_song_count);
			},
			error: function(data) {
				// make playlist errors reappear.
				container.find(".error").fadeIn(1000);
				container.find(".error").html("You have already upvoted this.");
				setTimeout(function(){
					container.find(".error").fadeOut(1000);
				},9000);
			}
		});
		
	});
	
	container.on("click", ".downvote_action", function(){
		var jukebox_song_id = container.find(this).attr("data-jukebox-song");

		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { vote: { jukebox_id: jukebox_id, jukebox_song_id: jukebox_song_id } },
			url: "/downvote",
			success: function(data) {
				client.publish("/update/juke_" + jukebox_id, data);
				container.find("#" + jukebox_song_id + " .jukebox_song_vote_count ").html(data.votes_jukebox_song_count);
			},
			error: function(data) {
				// make playlist errors reappear.
				container.find(".error").fadeIn(1000);
				container.find(".error").html("You have already downvoted this.");
				setTimeout(function(){
					container.find(".error").fadeOut(1000);
				},9000);
			}
		});
		
	});
	
	/** 
	setInterval(function() {
		playlist.get_playlist();
	},UPDATE_PLAYLIST_INTERVAL);
	**/
});