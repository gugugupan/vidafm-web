// Usage :
// 		Call for lazy load
// Param :
// 		url_part - call method like : DOMAIN_URL/[url_part]?[params]...
// 		id - lazyload file's id (if have)
// 		params - after url like : DOMAIN_URL?[params]
function lazyload( url_part , id , params )
{
	$( "#refresh-link" ) .text( "载入中,请稍侯.." ) ;
	var get_url ;
	if ( id == -255 ) // come from Discover page
		get_url = "/discover/ajax_get_new_page?action_name=" + url_part + "&" + params ;
	else if ( id == -256 ) // come from Feeds page
		get_url = "/" + url_part + "/ajax_get_new_page?" + params ;
	else // come from User or Moment page
		get_url = "/" + url_part + "/" + id + "/ajax_get_new_page?" + params ;	

	$.get( get_url , function( data ) 
	{
		if ( data .length < 10 )
		{
			if ( $( "#feed_container" ) .attr( "type" ) == "following" )
				$( "#refresh-link" ) .text( "没有更多的关注了." ) ;
			else if ( $( "#feed_container" ) .attr( "type" ) == "followers" )
				$( "#refresh-link" ) .text( "没有更多的粉丝了." ) ;
			else
				$( "#refresh-link" ) .text( "没有更多的照片了." ) ;
			$( "#refresh-link" ) .removeClass( "mouse" ) ;
			$( "#refresh-link" ) .css( "cursor" , "default" ) ;
			$( "#refresh-link" ) .removeAttr( "href" ) ;
		} else
		{
			$( "#refresh-link" ) .text( "点击显示更多" ) ;
			if ( $( "#feed_container" ) .length > 0 )
			{
				$( "#feed_container .last_clearfix" ) .remove() ;
				$( "#feed_container" ) .append( data ) ;
				$( "#feed_container" ) .append( "<div class='clearfix last_clearfix'> </div>" ) ;
			} else 
				$( "#refresh-link" ) .before( data ) ;

			avatarShow() ;
			arangeImage() ;
			$( "img.lazy" ) .lazyload() ;
		}
	} ) ;
}
