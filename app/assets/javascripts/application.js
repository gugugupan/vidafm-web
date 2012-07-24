//= require jquery
//= require jquery_ujs

//= require autowidth
//= require autoresize
//= require btnfunction
//= require followinglist
//= require lazyload

//= require jquery.cycle.lite
//= require jquery.em
//= require jquery.mousewheel
//= require jScrollPane
//= require jquery.lazyload
//= require screen


function randomNumber( n )
{
	return Math .floor( Math .random() * n ) ;
}

// Login click function
$( document ) .ready( function () {
	$( "#login-button" ) .click( function() {
		$( "#login_with" ) .fadeIn( 300 ) ;
	});
	$( "#login" ) .click( function() {
		$( "#login_with" ) .fadeIn( 300 ) ;
	});
});

// center text box function
function showCenterBox( str )
{
	var showDiv = '<div id="temp-center-box">' + str + "</div>" ;
	$( "body" ) .append( showDiv ) ;
	var $select = $( "#temp-center-box" ) ;
	var top  = ( $( window ) .height() - $select .height() ) / 2 ;
	var left = ( $( window ) .width () - $select .width() ) / 2 ;
	$select .css( { "top" : top , "left" : left } ) ;
	$select .fadeIn( 400 , function() { setTimeout( function() { $select .remove() ; } , 500 ) } ) ;
	//$select .fadeIn( 400 , function() { $( this ) .hide() ; } ) ;	
}

// Adjust avatar picture
function avatarShow()
{
	var avatar = $(".avatar");
	for (var i = 0; i<$(".avatar").length; i++) {
				var avatarAddress = $(avatar[i]).children().attr("src");
				$(avatar[i]).css({"background":"url("+avatarAddress+")" , "background-position":"center"});
			};
}

function destroyDialog( type )
{
	var $selector = $( ".need_destroy" ) ;
	$selector .fadeOut( 500 ) ;
	if ( type == 1 )
		setTimeout( function() { $selector .remove() ; } , 1000 ) ;
}

function showActivityDetail( activity_url )
{
	if ( $( "#activity_detail" ) .length == 0 ) 
	{
		var showDiv = "<div class='need_destroy' id='activity_detail'> </div>"
		var imageDiv = "<img src=" + activity_url + " id='activity_detail_img' class='thumbnail'>" ;
		$( "body" ) .append( showDiv ) ;
		$( "#activity_detail" ) .append( imageDiv ) ;
		$( "#activity_detail" ) .css( "width"  , $( document ) .width () ) ;
		$( "#activity_detail" ) .css( "height" , $( document ) .height() ) ;
		$( "#activity_detail_img" ) .css( "height" , "auto" ) ;
		$( "#activity_detail_img" ) .css( "width" , "auto" ) ;
		$( "#activity_detail_img" ) .css( "left" , ( $( window ) .width() - 590 ) / 2 ) ;
		$( "#activity_detail_img" ) .css( "top" , $( window ) .height() * 0.05 + $( window ) .scrollTop() ) ;
		$( "#activity_detail" ) .fadeIn( 300 ) ;

		$( "#activity_detail" ) .click( function() {
			destroyDialog( 1 ) ;
		}) ;
	}
}
