//= require jquery
//= require jquery_ujs

//= require autoresize
//= require lazyload
//= require activity_window

//= require jquery.lazyload
//= require video
//= require soundmanager2

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
		if ( avatarAddress )
		{
			$( avatar[ i ] ) .attr( "style" , "background-image:url(" + avatarAddress + "); filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + avatarAddress + "',sizingMethod='scale');" ) ;
		}
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
