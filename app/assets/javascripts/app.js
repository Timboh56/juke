(function($) {
	
	$(function() {
		var ANIMATION_TIME = 500;
		
		// page animations
		$("header").animate({
			position: "absolute",
			top: "0px",
		},ANIMATION_TIME);
		
		$(".container").animate({
			opacity: .9
		},ANIMATION_TIME);
		
		/** setTimeout(function() {
			$("#notice").fadeOut('slow');
		},50000000); **/
    });
})(jQuery)