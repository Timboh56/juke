(function($) {
	
	$(function() {
		var ANIMATION_TIME = 500;
		var NOTICE_TIME = 9000;
		
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

function add_active_class_nav(link_id){
	$("nav").find("#" + link_id).addClass("active");
}