var map = function(map_container, myOptions) {

	return {
		initialize: function() {
			var mapOptions = myOptions || {
		    zoom: 10,
				center: new google.maps.LatLng(this.lat, this.long),
		    mapTypeId: google.maps.MapTypeId.ROADMAP,
		  };
			
			var my_map = new google.maps.Map(document.getElementById('map_container'), mapOptions);
			
			google.maps.event.addListener(my_map, 'click', function( event ){
			  alert( "Latitude: "+event.latLng.lat()+" "+", longitude: "+event.latLng.lng() ); 
			});
		},
		getLocation: function() {
			if(navigator.geolocation)
				navigator.geolocation.getCurrentPosition(this.setPosition.bind(this))
		},
		setPosition: function(position) {
			this.lat = position.coords.latitude;
			this.long = position.coords.longitude;
			this.initialize();
		}
	}
};

$(function() {
	var m = map("map_container");
	m.getLocation();
});