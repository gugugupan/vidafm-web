// Call for lazy load
function lazyload( url_part , id , page_now , max_page , part_name )
{
	$( "#refresh-link" ) .text( "载入中,请稍后.." ) ;
	page_now = page_now + 1 ;
	var get_url = "/" + url_part + "/" + id + "/ajax_get_new_page?page=" + page_now ;
	$.get( get_url , function( data ) 
	{
		$( "#refresh-link" ) .before( data ) ;
		//$( part_name ) .slideDown() ;
		if ( page_now == max_page )
		{
			$( "#refresh-link" ) .text( "没有更多的照片了." ) ;
		} else
		{
			$( "#refresh-link" ) .text( "点击显示更多" ) ;
		}
	} ) ;
	return page_now ; 
}
