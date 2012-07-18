
var prettyLoad = '\
				<li class="list">\
					<a class="user_name">请稍后..</a>\
					<div class="clearfix"></div>\
				</li>' ;

// Create a window
function showFollowingDialog( num , count_following , count_followed )
{
	var listDiv = '\
		<div id="follow_list" class="popup_container need_destroy">\
			<div class="tab">\
				<a id="gz_btn" href=javascript:showFollowingList('+num+','+0+')>关注 '+count_following+'</a>\
				<a id="fs_btn" href=javascript:showFollowingList('+num+','+1+')>粉丝 '+count_followed+'</a>\
				<div class="clearfix"></div>\
			</div>\
			<img src="/assets/images/list_shadow.png" class="shadow">\
			<ul>\
			</ul>\
			<a class="destroy-tag" href=javascript:destroyDialog(1)>\
				<img src="/assets/images/icon_cancel.png">\
			</a>\
		</div>' ;
	if ( $( "#follow_list" ) .length == 0 )
	{
		$( "body" ) .append( listDiv ) ;
		$selector = $( "#follow_list" ) ;
		$selector .show( 500 ) ;
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
		$ulSelector .slideDown( 'fast' ) ;
	}) ;
}
