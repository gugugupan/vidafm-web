$(window).load(function () {
	var avatar = $(".avatar");
	var featrueUser = $(".feature_user");
	var thumbnail = $(".thumbnail");

	for (var i=0; i<$(".feature_user").length; i++) {
		if ($(featrueUser[i]).hasClass("big")) {
			$(featrueUser[i]).find(".btn_blue").addClass("btn_middle");
		} else if ($(featrueUser[i]).hasClass("normal")) {
			$(featrueUser[i]).find(".btn_blue").addClass("btn_small");
		}
	}

	avatarShow() ;

	//thumbnail position
	/*
	for (var i = 0; i<$(".thumbnail").length; i++) {
		var ratioContainer = $(thumbnail[i]).height() / $(thumbnail[i]).width();
		var ratioPhoto = $(thumbnail[i]).find("img").height() / $(thumbnail[i]).find("img").width();
		
		if (ratioPhoto == ratioContainer) {

			$(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"100%"});

		} else if (ratioPhoto < ratioContainer) {

			$(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"auto"});
			var x = -($(thumbnail[i]).find("img").width() - $(thumbnail[i]).width()) / 2;
			$(thumbnail[i]).find("img").css({"margin-left":x});

		} else if (ratioPhoto > ratioContainer) {

			$(thumbnail[i]).find("img").css({"height":"auto"}).css({"width":"100%"});
			var y = -($(thumbnail[i]).find("img").height() - $(thumbnail[i]).height()) / 2;
			$(thumbnail[i]).find("img").css({"margin-top":y});

		}
	};
	*/

	$(".story_container .info_container:first-child").css({'border-top':'none'});
	$(".story_container .info_container:last-child").css({'border-bottom':'none'});

	$(".thumbnail").hover(
		function() {
			$( this ) .find( ".thumb_like" ) .fadeIn( "fast" ) ;
		} ,
		function() {
			$( this ) .find( ".thumb_like" ) .fadeOut( "fast" ) ;
		}
	);

	$("#me_filter").hover(function(){
		$("#me_filter .popup_container").slideToggle(100);
	});

	$(".popup_container .list:first-child").css({
		'border-top':'none',
		'border-top-left-radius':'8px',
		'border-top-right-radius':'8px',
	});

	$(".popup_container .list:last-child").css({
		'border-bottom':'none',
		'border-bottom-left-radius':'8px',
		'border-bottom-right-radius':'8px',
	});

	$(".tab a:first-child").css({
		'border-top-left-radius':'6px',
		'border-bottom-left-radius':'6px',
	});

	$(".tab a:eq(1)").css({
		'border-left':'1px solid #666666',
		'border-top-right-radius':'6px',
		'border-bottom-right-radius':'6px',
	});
});
