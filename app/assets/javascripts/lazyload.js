// Call for lazy load
function lazyload( url_part , id , page_now )
{
	$( "#refresh-link" ) .text( "载入中,请稍后.." ) ;
	page_now = page_now + 1 ;
	var get_url = "/" + url_part + "/" + id + "/ajax_get_new_page?page=" + page_now ;
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
			$( "#refresh-link" ) .before( data ) ;
			$( "#refresh-link" ) .text( "点击显示更多" ) ;
		}
        autoWidthPhoto() ;
        avatarShow() ;
	} ) ;
	return page_now ; 
}
