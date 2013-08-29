$(function(){
	var UPDATE_INTERVAL = 1000;
	
	// get container from DOM
	var container = $(".container");
	
	// get ID of jukebox from jukebox_header
	var id = container.find(".jukebox_header").attr("id");
		
	var username = container.find(".chat_room").attr("data-username");
	
    // Create a new client to connect to Faye
    var client = new Faye.Client("http://localhost:9292/faye");
    var height = $(".chat_room").height();	
	var msgs = 0;
	
	// handle song submission functionality
	$(".search_song").on("click",function(e) {
		e.preventDefault();
		// get song artist field
		var search = container.find("#search").val();

		$.ajax({
			type: "PUT",
			dataType: "jsonp",
			data: { search: search, jukebox_id: id },
			url: "/search_for_songs",
			complete: function(msg) {
				$("#results_list").append(msg.responseText);
			}
		});
	});
	
    // Subscribe to the jukebox channel
    var chat_sub = client.subscribe("/chats/juke_" + id, function(data) {
	  msgs++;
	  $(".chat_room").animate({ scrollTop: msgs*height },"50");
      $("<div class=\"message\">").html(data.username + ": " + data.msg).appendTo(".chat_room");
    });
	
	var playlist_sub = client.subscribe("/playlists/juke_" + id, function(data) {
		$("<div class=\"song\">").html("\""+ data.song_title + "\", by " + data.artist).appendTo(".playlist");	
	});
 
    // Handle form submissions and post messages to faye
    $("#new_message_form").submit(function(event) {
		event.preventDefault();
      // Publish the message to the public channel
      client.publish("/chats/juke_" + id, {
        username: username,
        msg: $("#message").val()
      });
 
      // Clear the message box
      $("#message").val("");
 
      // Don"t actually submit the form, otherwise the page will refresh.
      return false;
    });
});