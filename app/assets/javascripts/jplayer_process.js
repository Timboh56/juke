
var init_jplayer = function(id){
	$("#" + id).jPlayer({
		ready: function (event) {
			$(this).jPlayer("setMedia", {
				mp3: "/tunes/home.mp3"
			});
		},
		swfPath: "js",
		supplied: "mp3",
		wmode: "window",
		smoothPlayBar: true,
		keyEnabled:true
	});
}

var jsplayer = function(client,id) {
	
	// everytime the client receives a new song,
	// 1. rerank the playlist
	// 2. 
	client.subscribe("playlists/juke_" + id, function(data){
		
	
	});
}