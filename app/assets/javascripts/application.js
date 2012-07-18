//= require jquery

//= require autowidth
//= require btnfunction
//= require followinglist

//= require jquery.em
//= require jquery.mousewheel
//= require jScrollPane
//= require screen


function randomNumber( n )
{
	return Math .floor( Math .random() * n ) ;
}

// Login click function
$( document ) .ready( function () {
	$("#login-button").click( function() {
		$("#login_with").show(300);
	});
	$("#login").click( function() {
		$("#login_with").show(300);
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
	$select .show( 500 ) ;
	setTimeout( function() { $select .remove() ; } , 2500 ) ;
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
	$selector .hide( 700 ) ;
	if ( type == 1 )
		setTimeout( function() { $selector .remove() ; } , 1000 ) ;
}
