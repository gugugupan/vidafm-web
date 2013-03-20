//= require jquery
//= require jquery_ujs

var window_height , window_width ;
var slideshow_num = -1 ;
var animate_speed = 500 ;
var lock_array = new Array() ;
var slideshow_length ;

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
	close_animate( function() {
		if ( slideshow_num != -1 )
		{
			$( ".slideshow_window" ) .eq( slideshow_num ) .fadeOut( 0 ) ;
			close_zoom() ;
		}

		slideshow_num = num ;
		var $selector = $( ".slideshow_window" ) .eq( num ) ;
		var img_height = $selector .attr( "cheight" ) , img_width = $selector .attr( "cwidth" ) ;
		$selector .find( ".info_window" ) .fadeOut( 0 ) ;

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

		open_zoom() ; // zoom in the picture
		open_animate() ; // start animation
	} ) ;
}

function open_animate()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) ;
	$( ".cover" ) .fadeOut( 0 ) ;

	var animate = parseInt( Math.random() * 4 ) + 1 ;
	//var animate = 4 ;
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
		case 2 :
			$selector .find( "#left_cover" ) .eq( 0 ) .css( { width : "100%" , 
															  display: "block" } ) ;
			$selector .find( "#top_cover" ) .eq( 0 ) .css( { height : "47%" , 
															 display: "block" } ) ;
			$selector .find( "#bottom_cover" ) .eq( 0 ) .css( { height : "47%" , 
																display: "block" } ) ;
			break ;
		case 3 :
			$selector .find( "#left_cover" ) .eq( 0 ) .css( { width : "0%" , 
															  display : "block" } ) ;
			$selector .find( "#right_cover" ) .eq( 0 ) .css( { width : "100%" , 
															   display : "block" } ) ;
			break ;
		case 4 :
			$selector .find( "#left_cover" ) .eq( 0 ) .css( { width : "100%" , 
															  display : "block" } ) ;
			$selector .find( "#right_cover" ) .eq( 0 ) .css( { width : "0%" , 
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
		case 2 :
			$selector .find( "#left_cover" ) .eq( 0 ) .animate( { width : "0%" } , animate_speed , 
				function() {
					$selector .find( "#top_cover" ) .eq( 0 ) .animate( { height : "0%" } , animate_speed ) ;
					$selector .find( "#bottom_cover" ) .eq( 0 ) .animate( { height : "0%" } , animate_speed , show_photo ) ;
				} ) ;
			break ;
		case 3 :
			$selector .find( "#right_cover" ) .animate( { width: "95%" } , 0 , function() {
				$selector .find( "#left_cover" ) .animate( { width: "95%" } , animate_speed ) ;
				$selector .find( "#right_cover" ) .animate({ width: "0%" } , animate_speed ) ;
			}) ;
			$selector .find( "#left_cover" ) .animate( { width: "0%" } , animate_speed , show_photo ) ;
			break ;
		case 4 :
			$selector .find( "#left_cover" ) .animate( { width: "95%" } , 0 , function() {
				$selector .find( "#right_cover" ) .animate( { width: "95%" } , animate_speed ) ;
				$selector .find( "#left_cover" ) .animate({ width: "0%" } , animate_speed ) ;
			}) ;
			$selector .find( "#right_cover" ) .animate( { width: "0%" } , animate_speed , show_photo ) ;
			break ;
	}
}

function show_photo()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) ;
	$selector .find( ".info_window" ) .fadeIn( animate_speed ) ;
	setTimeout( play_next , 4000 ) ;
}

function close_animate( callback )
{
	if ( slideshow_num == -1 ) 
	{
		callback() ;
		return ;
	}

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
			$selector .find( "#left_cover" ) .eq( 0 ) .animate( { width: "51%" } , animate_speed , callback ) ;
			break ;
		case 2 :
			$selector .find( "#top_cover" ) .eq( 0 ) .animate( { height: "51%" } , animate_speed ) ;
			$selector .find( "#bottom_cover" ) .eq( 0 ) .animate( { height: "51%" } , animate_speed , callback ) ;
			break ;
	}
}

function play_next()
{
	if ( slideshow_num < slideshow_length - 1 )
		go_slideshow( slideshow_num + 1 ) ;
	else close_animate( function() {
		$( ".slideshow_window" ) .eq( slideshow_num ) .fadeOut( 0 ) ;
		close_zoom() ;

		$( "#slideshow_end" ) .fadeIn( animate_speed ) ;
	} ) ;
}
