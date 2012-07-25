var prettyLoad = '\
				<li class="list">\
					<a class="user_name">请稍后..</a>\
					<div class="clearfix"></div>\
				</li>' ;

// Create a window
function showFollowingDialog( num , count_following , count_followed )
{
	var listDiv = '\
	<div id="following_detail" class="black_background need_destroy">\
		<div id="follow_list" class="popup_container">\
			<div class="tab">\
				<a id="gz_btn" href=javascript:showFollowingList('+num+','+0+')>关注 '+count_following+'</a>\
				<a id="fs_btn" href=javascript:showFollowingList('+num+','+1+')>粉丝 '+count_followed+'</a>\
				<div class="clearfix"></div>\
			</div>\
			<img src="/assets/images/list_shadow.png" class="shadow">\
			<ul>\
			</ul>\
		</div>\
	</div>' ;
	if ( $( "#follow_list" ) .length == 0 )
	{
		$( "body" ) .append( listDiv ) ;
		var $selector = $( "#following_detail" ) ;
		$selector .css( "height" , $( document ) .height() ) ;
		$selector .fadeIn( 500 ) ;

		$( "#following_detail" ) .click( function() {
			destroyDialog( 1 ) ;
		});

		showFollowingList( num , 0 ) ;
	}
}

// show list
function showFollowingList( num , type )
{
	var Str = [ "following" , "followed_by" ] ;
	var $ulSelector = $( "#follow_list" ) .find( "ul" ) .eq( 0 ) ;
	$ulSelector .empty() ;
	$ulSelector .append( prettyLoad ) ;
	var get_url = "/users/" + num + "/ajax_following_list?relation=" + Str[ type ] ;
	$.get( get_url , function( getData ) {
		$ulSelector .hide() ;
		$ulSelector .empty() ;
		$ulSelector .append( getData ) ;
		avatarShow() ;
		$ulSelector .slideDown() ;
	}) ;
}
