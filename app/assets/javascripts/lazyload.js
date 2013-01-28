// Call for lazy load
function lazyload( url_part , id , params )
{
	$( "#refresh-link" ) .text( "载入中,请稍侯.." ) ;
	var get_url ;
	if ( id == -255 )
		get_url = "/discover/ajax_get_new_page?action_name=" + url_part + "&" + params ;
	else if ( id == -256 )
		get_url = "/" + url_part + "/ajax_get_new_page?" + params ;
	else
		get_url = "/" + url_part + "/" + id + "/ajax_get_new_page?" + params ;

	//alert( get_url ) ;

	$.get( get_url , function( data ) 
	{
		if ( data .length < 10 )
		{
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
			repeat_check( arangeImage ) ;
			$( "img.lazy" ) .lazyload() ;
		}
	} ) ;
}
