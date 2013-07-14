//= require jquery
//= require jquery_ujs

//= require autoresize
//= require lazyload
//= require activity_window
//= require scroll

//= require plugin/jquery.lazyload
//= require video
//= require soundmanager2-nodebug-jsmin

jQuery( function() {
	gaDownload() ;
    arangeImage() ;
	// Login function
	$( ".login_btn" ) .click( function() {
		$( "#login_detail" ) .fadeIn( 400 ) ;
		$( "body" ) .css( "overflow-y" , "hidden" ) ;
	});
	$( "#login_detail" ) .click( function() {
		destroyDialog( 0 ) ;
		$( "body" ) .css( "overflow-y" , "scroll" ) ;
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

// Remove dialog box
function destroyDialog( type )
{
	var $selector = $( ".need_destroy" ) ;
	$selector .fadeOut( 500 ) ;
	if ( type == 1 )
		setTimeout( function() { $selector .remove() ; } , 500 ) ;
}

// Download GA
function gaDownload()
{
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-19458693-4']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
}
