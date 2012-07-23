// Like function
function likeActivity( num )
{
	var get_url = "/moments/" + num + "/ajax_like.json" ;
	$.get( get_url , function( likeResult ) {
		if ( likeResult .result == 0 )
		{
			var nowLikedCountStr = $( "#like" + num ) .text() ;
			var nowLikedCount = parseInt( nowLikedCountStr ) + 1 ;
			$( "#like" + num ) .text( nowLikedCount ) ;
			$( "#like" + num ) .addClass( "liked" ) ;
			showCenterBox( likeResult .message ) ;
		}
		else {
			showCenterBox( likeResult .message ) ;
		}
	});
}

// Comment Show
function callComment( num )
{
	$( "#" + num + "comment" ) .slideToggle() ;
}

// Following somebody
function followingSomebody( uid )
{
	var get_url = "/users/" + uid + "/ajax_following.json?type=following"
	var $selector = $( "#following-tag" ) ;
	$selector .text( "请稍后.." ) ;
	$.get( get_url , function( followResult ) {
		if ( followResult .result == 0 )
		{
			if ( followResult .data .relation == "pending" )
			{
				$selector .text( "等待" ) ;
				$selector .removeAttr( "href" ) ;
				$selector .attr( "id" , "waiting-tag" ) ;
				$selector .removeClass( "btn_red" ) ;
				$selector .addClass( "btn_dark" ) ;
			} else 
			{
				$selector .text( "取消关注" ) ;
				$selector .attr( "href" , "javascript:cancelFollowSomebody(" + uid + ")" ) ;
				$selector .attr( "id" , "cancel-tag" ) ;
				$selector .removeClass( "btn_blue" ) ;
				$selector .addClass( "btn_red" ) ;
			}
			showCenterBox( followResult .message ) ;
		} else 
		{
			showCenterBox( followResult .message ) ;
		}
	});
}

function cancelFollowSomebody( uid )
{
	var get_url = "/users/" + uid + "/ajax_following.json?type=none"
	var $selector = $( "#cancel-tag" ) ;
	$selector .text( "请稍后.." ) ;
	$.get( get_url , function( result ) {
		$selector .text( "+关注" ) ;
		$selector .attr( "href" , "javascript:followingSomebody(" + uid + ")" ) ;
		$selector .attr( "id" , "following-tag" ) ;
		$selector .removeClass( "btn_red" ) ;
		$selector .addClass( "btn_blue" ) ;
		showCenterBox( result .message ) ;
	});
}
