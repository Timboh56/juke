(function($) {
	
	$(function() {
		var ANIMATION_TIME = 500;
		var NOTICE_TIME = 5000;
		
		// page animations
		$("header").animate({
			position: "absolute",
			top: "0px",
		},ANIMATION_TIME);
		
		$(".container").animate({
			opacity: .9
		},ANIMATION_TIME);
		
		setTimeout(function() {
			$("#notice").fadeOut('slow');
		},NOTICE_TIME);
    });
})(jQuery)