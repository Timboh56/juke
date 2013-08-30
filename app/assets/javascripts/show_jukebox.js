var client = new Faye.Client("http://localhost:9292/faye");

$(function(){
	var UPDATE_INTERVAL = 1000;
	
	// get container from DOM
	var container = $(".container");
	
	// get ID of jukebox from jukebox_header
	var jukebox_id = container.find(".jukebox_header").attr("id");
		
	var username = container.find(".chat_room").attr("data-username");
	
    // Create a new client to connect to Faye
    var height = $(".chat_room").height();	
	var msgs = 0;
	
	container.on("click", ".result_action", function(){
		var song_id = $(this).attr("data");
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { jukebox_song: {jukebox_id: jukebox_id, song_id: song_id} },
			url: "/add_song_to_jukebox",
			success: function(msg) {
					container.find(".playlist").html(msg.responseText);
			},		
			error: function(msg){
						// make playlist errors reappear.
						container.find(".error").fadeIn(1000);
						container.find(".error").html("You already added that");
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
			dataType: "json",
			data: { search: search, jukebox_id: jukebox_id },
			url: "/search_for_songs",
			success: function(msg) {
				$("#results_list").html(msg.responseText);
			}
		});
	});
	
	// Suscribe to jukebox playlist
	var playlist_sub = client.subscribe("/playlists/juke_" + jukebox_id, function(data) {
		$("<div class=\"song\">").html("\""+ data.song_title + "\", by " + data.artist).appendTo(".playlist");	
	});
	
    // Subscribe to the jukebox chatroom channel
    var chat_sub = client.subscribe("/chats/juke_" + jukebox_id, function(data) {
	  msgs++;
	  container.find(".chat_room").animate({ scrollTop: msgs*height },"50");
      $("<div class=\"message\">").html(data.username + ": " + data.msg).appendTo(".chat_room");
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
		var jukebox_song_id = $(this).attr("data-jukebox-song");
		var votes_count = container.find("#" + jukebox_song_id).html();
		$.ajax({
			type: "PUT",
			dataType: "json",
			data: { vote: { jukebox_id: jukebox_id, jukebox_song_id: jukebox_song_id } },
			url: "/upvote",
			success: function(data) {
				container.find(".submitted_by #" + jukebox_song_id).html("<h2>" + data.votes_jukebox_song_count);
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
	
	init_jplayer("jquery_jplayer_1");
	
	jsplayer(client,jukebox_id);
});