(function($) {
	
	$(function() {
		
		// page animations
		$("header").animate({
			position: "absolute",
			top: "0px",
		},1000);
		
		$(".container").animate({
			opacity: .96
		},1000);
    });
})(jQuery)