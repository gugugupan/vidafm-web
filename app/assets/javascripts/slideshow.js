//= require jquery
//= require jquery_ujs
//= require pixastic.custom
//= require soundmanager2-nodebug-jsmin

var window_height , window_width ;
var slideshow_num = -1 ;
var animate_speed = 300 ;
var slideshow_length ;
var is_pause = false ;
var will_pause = false ;
var is_end = false ;

jQuery( function() {
	window_width  = $( window ) .width() || $( document ) .width() ;
	window_height = $( window ) .height() || $( document ) .height() ;
	slideshow_length = $( ".slideshow_window" ) .length ;
} ) ;

function blur_start( img_id )
{
	var $img_obj = $( "#" + img_id ) .eq( 0 ) ;
	var $box_obj = $img_obj .parent() ;
	var img_width = $img_obj .attr( "cwidth" ) ,
		img_height = $img_obj .attr( "cheight" ) ;
	var window_ratio = window_width / window_height ;
	var img_ratio = img_width / img_height ; 
	if ( window_ratio < img_ratio ) {
		$img_obj .css( {
			width : img_width * ( window_height / img_height ) ,
			height : window_height ,
			"margin-left" : ( window_width - img_width * ( window_height / img_height ) ) / 2 
		} ) ;
	} else {
		$img_obj .css( {
			width : window_width , 
			height : img_height * ( window_width / img_width ) ,
			"margin-top" : ( window_height - img_height * ( window_width / img_width ) ) / 2 
		} ) ;
	}

	var img_ele = document.getElementById( img_id ) ;
	img_ele .onload = function() {
		Pixastic.process( img_ele , "blurfast", { amount : 1.5 } ) ;
	}
	img_ele .src = img_ele .attributes[ "imgsrc" ] .nodeValue ;
}

var color_list = [ "#476A7F" , "#805889" , "#DB4565" , "#D1664E" , "#D68147" , "#89A06D" ] , now_color = 0 ;
function change_color()
{
	now_color = ( now_color + 1 ) % 6 ;
	$( ".bcolor" ) .css( "background-color" , color_list[ now_color ] ) ;
}

var zoom_interval = null ;
function open_zoom()
{
	var $selector = $( ".slideshow_window" ) .eq( slideshow_num ) .find( ".slideshow_img" ) .eq( 0 ) ;
	var initial_width =  $( ".slideshow_window" ) .eq( slideshow_num ) .width() ;
	var time_left = 0 ;
	zoom_interval = setInterval( function() {
		time_left ++ ;
		if ( time_left <= 120 )
		{
			$selector .css( { width : initial_width + time_left * 2 ,
							  "margin-left" : ( -time_left ) + "px" , 
							  "margin-top" : ( -time_left ) + "px" } ) ;
		} else clearInterval( zoom_interval ) ;
	} , 50 ) ;
}

function close_zoom()
{
	clearInterval( zoom_interval ) ;
}


/*=================    Music Function    ====================*/
var music_num = 0 ;
var music ;
function play_background_music() {
	/*
		Start play background music randomly
	*/
    if ( soundManager.ok() ) 
    {
		music_num = ( music_num + parseInt( Math.random() * 4 ) + 1 ) % 5 ;
		music = soundManager .getSoundById( "bmusic" + music_num ) ;
		if ( !music )
			music = soundManager.createSound( {
				id: "bmusic" + music_num ,
				url: "/mp3/slideshow" + music_num + ".m4a" ,
				onfinish: function() {
					play_background_music() ;
				} 
			} ) ;
		music .play() ;
	}
}



function sink_animate( $image_selector , $text_selector , callback )
{
	change_color() ;
	$image_selector .css( "margin-top" , "-50px" ) ;
	$image_selector .show( 0 ) ;
	$text_selector  .show( 0 ) ;
	$image_selector .animate( { 
		"margin-top" : "0px" ,
		"opacity" : "1" 
	} , 800 ) ;
	$text_selector  .animate( { "opacity" : "1" } , 800 ) ;
	setTimeout( function() { 
		$image_selector .fadeOut( 300 ) ;
		$text_selector  .fadeOut( 300 ) ;
		setTimeout( callback , 1000 ) ;
	} , 1500 ) ;
}


function start_slideshow()
{
	$( "#slideshow_index" ) .fadeOut( animate_speed ) ;
	$( "#slideshow_header" ) .fadeOut( animate_speed ) ;
	$( "#slideshow_end" ) .fadeOut( animate_speed ) ;
	$( "#slideshow_background" ) .fadeOut( animate_speed ) ;
	$( "body" ) .css( "background-image" , "none" ) ;
	is_end = false ;
	bar_on() ;
	play_background_music() ;

	setTimeout( function() {
		var $selector = $( "#slideshow_start" ) ;
		$selector .show( 0 ) ;
		sink_animate( $selector .find( "#start_user_avatar" ) , $selector .find( "#start_user_name" ) , function() {
		sink_animate( $selector .find( "#start_category_img" ),$selector .find( "#start_category_text" ) , function() {
		sink_animate( $selector .find( "#start_date_img" ) , $selector .find( "#start_date_text" ) , function() {
			$selector .hide( 0 ) ;
			go_slideshow( 0 ) ;
		} ) ;
		} ) ;
		} ) ;
	} , animate_speed ) ;
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

		change_color() ;

		$selector .find( ".slideshow_img" ) .load( function() {
			open_zoom() ; // zoom in the picture
			open_animate() ; // start animation
		} ) ;
		$selector .find( ".slideshow_img" ) .attr( "src" , $selector .find( ".slideshow_img:eq(0)" ) .attr( "imgsrc" ) ) ;
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
			$selector .find( "#right_cover" ) .animate( { width: "90%" } , 0 , function() {
				$selector .find( "#left_cover" ) .animate( { width: "90%" } , animate_speed ) ;
				$selector .find( "#right_cover" ) .animate({ width: "0%" } , animate_speed ) ;
			}) ;
			$selector .find( "#left_cover" ) .animate( { width: "0%" } , animate_speed , show_photo ) ;
			break ;
		case 4 :
			$selector .find( "#left_cover" ) .animate( { width: "90%" } , 0 , function() {
				$selector .find( "#right_cover" ) .animate( { width: "90%" } , animate_speed ) ;
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
	setTimeout( play_next , 5000 ) ;
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
	if ( will_pause ) 
	{
		is_pause = true ;
		return ;
	}
	if ( slideshow_num < slideshow_length - 1 )
	{
		go_slideshow( slideshow_num + 1 ) ;
	}
	else close_animate( ending_slideshow ) ;
}

function ending_slideshow()
{
	$( ".slideshow_window" ) .eq( slideshow_num ) .fadeOut( 0 ) ;
	close_zoom() ;
	is_end = true ;

	setTimeout( function() {
		bar_off() ;
		$( "#slideshow_end" ) .fadeIn( animate_speed ) ;
		$( "#slideshow_header" ) .fadeIn( animate_speed ) ;
		$( "#slideshow_background" ) .fadeIn( animate_speed ) ;
	} , 500 ) ;
}

/*=================    Bar Function    ====================*/

function bar_play()
{
	$( ".slideshow_bar_pause" ) .css( "display" , "block" ) ;
	$( ".slideshow_bar_play" ) .css( "display" , "none" ) ;
}

function bar_pause()
{
	$( ".slideshow_bar_pause" ) .css( "display" , "none" ) ;
	$( ".slideshow_bar_play" ) .css( "display" , "block" ) ;
}

function bar_on()
{
	bar_play() ;
	$( "#slideshow_bar" ) .fadeOut( 0 ) ;
	$( "#slideshow_bar_container" ) .mouseenter( function() {
		$( "#slideshow_bar" ) .fadeIn( 100 ) ;
	} ) .mouseleave( function() {
		$( "#slideshow_bar" ) .fadeOut( 100 ) ;
	} ) ;
}

function bar_off()
{
	bar_pause() ;
	$( "#slideshow_bar" ) .css( "display" , "block" ) ;
	$( "#slideshow_bar_container" ) .unbind() ;
}

function play_pause()
{
	if ( is_end )
	{
		start_slideshow() ;
	} else 
	if ( is_pause )
	{
		is_pause = false ;
		will_pause = false ;
		bar_play() ;
		play_next() ;
	} else
	if ( will_pause )
	{
		will_pause = false ;
		bar_play() ;
	} else
	{
		will_pause = true ;
		bar_pause() ;
	}
}

function music_btn()
{
}

// Remove dialog box
function destroyDialog( type )
{
	var $selector = $( ".need_destroy" ) ;
	$selector .fadeOut( 500 ) ;
	if ( type == 1 )
		setTimeout( function() { $selector .remove() ; } , 500 ) ;
}

// center text box function
function showCenterBox( str )
{
	if ( $( "#temp-center-box" ) .length == 0 )
	{
		var showDiv = '<div id="temp-center-box">' + str + "</div>" ;
		$( "body" ) .append( showDiv ) ;
		var $select = $( "#temp-center-box" ) ;
		var top  = ( $( window ) .height() - $select .height() ) / 2 ;
		var left = ( $( window ) .width () - $select .width() ) / 2 ;
		$select .css( { "top" : top , "left" : left } ) ;
		if( $.browser.msie )
			$select .css( "background-color" , "gray" ) ;
		$select .fadeIn( 400 , function() { setTimeout( function() { $select .remove() ; } , 1000 ) } ) ;
	}
}