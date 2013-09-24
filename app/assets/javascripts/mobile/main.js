$(function(){
	var hidden = true;
	$('#menu_icon').on("click",function(){
		if(hidden){
			$(".mobile_nav_links").show("slide", { direction: "left" }, 2000);
		} else {
			$(".mobile_nav_links").hide("slide", { direction: "left" }, 2000);	
		}
		hidden = !hidden;
	});
});