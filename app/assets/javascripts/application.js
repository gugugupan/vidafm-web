//= require jquery
//= require jquery_ujs

//= require autoresize
//= require followinglist
//= require lazyload
//= require activity_window

//= require blur.js
//= require jquery.cycle.lite
//= require jquery.lazyload
//= require video

(function($){
	// LIVE function
	$( "form" ) .live( "submit" , function() { 
		$( this ) .find( "input,textarea" ) .css( "background-color" , "rgba(0,0,0,0.3)" ) ; 
	}) ;
	$( ".more_comment" ) .live( "click" , function() {
		$( this ) .text( "载入中.." ) ;
	}) ;
	$( ".one_comment" ) .live( "click" , function() {
		var name = $( this ) .find( ".user_name" ) .eq( 0 ) .text() ;
		name = name .replace( " " , "" ) ;
		var text = $( this ) .parent() .parent() .find( "input" ) .val() ;
		$( this ) .parent() .parent() .find( "input" ) .val( "回复@" + name + ":" ) ;
		$( this ) .parent() .parent() .find( "input" ) .focus() ;
	}) ;
})(jQuery);

jQuery( function() {
	avatarShow() ;
    arangeImage() ;
	// Login function
	$( ".login_btn" ) .click( function() {
		$( "#login_detail" ) .fadeIn( 400 ) ;
	});
	$( "#login_detail" ) .click( function() {
		destroyDialog( 0 ) ;
	}) ;
});

// get a random number
function randomNumber( n )
{
	return Math .floor( Math .random() * n ) ;
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
		//$select .fadeIn( 400 , function() { $( this ) .hide() ; } ) ;	
	}
}

// Adjust avatar picture
function avatarShow()
{
	var avatar = $("a.avatar");
	for (var i = 0; i<$(".avatar").length; i++) {
		var avatarAddress = $(avatar[i]).children().attr("src");
		$(avatar[i]).css({"background":"url("+avatarAddress+")" , "background-position":"center"});
	};
}

// Remove dialog box
function destroyDialog( type )
{
	var $selector = $( ".need_destroy" ) ;
	$selector .fadeOut( 500 ) ;
	if ( type == 1 )
		setTimeout( function() { $selector .remove() ; } , 500 ) ;
}
