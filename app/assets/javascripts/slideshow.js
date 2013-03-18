//= require jquery
//= require jquery_ujs

var window_height , window_width ;
var slideshow_num = 0 ;
var animate_speed = 500 ;

var zoom_interval = null ;
function open_zoom()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) .find( ".slideshow_img" ) .eq( 0 ) ;
	var initial_width =  $( ".slideshow_window" ) .eq( slideshow_num ) .width() ;
	var time_left = 0 ;
	zoom_interval = setInterval( function() {
		time_left ++ ;
		$selector .css( { width : initial_width + time_left * 2 ,
						  "margin-left" : ( -time_left ) + "px" , 
						  "margin-top" : ( -time_left ) + "px" } ) ;
	} , 50 ) ;
}

function close_zoom()
{
	clearInterval( zoom_interval ) ;
}

function go_slideshow( num )
{
	slideshow_num = num ;
	var $selector = $( ".slideshow_window" ) .eq( num ) ;
	var img_height = $selector .attr( "cheight" ) , img_width = $selector .attr( "cwidth" ) ;

	// fix slideshow window's width and height
	var window_ratio = window_width / window_height ;
	var img_ratio = img_width / img_height ; 
	if ( window_ratio > img_ratio ) {
		$selector .css( {
			width : img_width * ( window_height / img_height ) ,
			height : window_height ,
			"margin-left" : ( window_width - img_width * ( window_height / img_height ) ) / 2 
		} ) ;
	} else {
		$selector .css( {
			width : window_width , 
			height : img_height * ( window_width / img_width ) ,
			"margin-top" : ( window_height - img_height * ( window_width / img_width ) ) / 2 
		} ) ;
	}
	open_zoom() ;
	open_animate() ;
}

function open_animate()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) ;
	$( ".cover" ) .fadeOut( 0 ) ;

	var animate = parseInt( Math.random() ) + 1 ;
	switch ( animate )
	{
		case 1 :
			$selector .find( "#left_cover" ) .eq( 0 ) .css( { width : "47%" , 
															  display : "block" } ) ;
			$selector .find( "#right_cover" ) .eq( 0 ) .css( { width : "47%" , 
															   display : "block" } ) ;
			$selector .find( "#top_cover" ) .eq( 0 ) .css( { height : "100%" , 
															 display : "block" } ) ;
			break ;
	}
	$selector .fadeIn( 0 ) ;
	switch ( animate )
	{
		case 1 :
			$selector .find( "#top_cover" ) .eq( 0 ) .animate( { height : "0%" } , animate_speed , 
				/*Call back*/ function() {
					$selector .find( "#left_cover" ) .eq( 0 ) .animate( { width : "0%" } , animate_speed ) ;
					$selector .find( "#right_cover" ) .eq( 0 ) .animate( { width : "0%" } , animate_speed , show_photo ) ;
				} ) ;
			break ;
	}
}

function show_photo()
{
	setTimeout( close_animate , 4000 ) ;
}

function close_animate()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) ;
	$( ".cover" ) .fadeOut( 0 ) ;

	var animate = parseInt( Math.random() * 2 ) + 1 ;
	switch ( animate )
	{
		case 1 :
			$selector .find( "#left_cover" ) .eq( 0 ) .css( { width : "0%" , 
															  display : "block" } ) ;
			$selector .find( "#right_cover" ) .eq( 0 ) .css( { width : "0%" , 
															   display : "block" } ) ;
			break ;
		case 2 :
			$selector .find( "#top_cover" ) .eq( 0 ) .css( { height : "0%" , 
															 display : "block" } ) ;
			$selector .find( "#bottom_cover" ) .eq( 0 ) .css( { height : "0%" , 
																display : "block" } ) ;
			break ;
	}
	switch ( animate )
	{
		case 1 :
			$selector .find( "#right_cover" ) .eq( 0 ) .animate( { width: "51%" } , animate_speed ) ;
			$selector .find( "#left_cover" ) .eq( 0 ) .animate( { width: "51%" } , animate_speed , play_next ) ;
			break ;
		case 2 :
			$selector .find( "#top_cover" ) .eq( 0 ) .animate( { height: "51%" } , animate_speed ) ;
			$selector .find( "#bottom_cover" ) .eq( 0 ) .animate( { height: "51%" } , animate_speed , play_next ) ;
			break ;
	}
}

function play_next()
{
	$( ".slideshow_window" ) .eq( slideshow_num ) .fadeOut( 0 ) ;
	close_zoom() ;

	setTimeout( function() {
		if ( slideshow_num < $( ".slideshow_window" ) .length )
			go_slideshow( slideshow_num + 1 ) ;
	} , 1000 ) ;
}

// go_slideshow => open_animate => show_photo => close_animate => go_slideshow
