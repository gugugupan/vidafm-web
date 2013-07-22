var SCROLL_TIME = 700.0 ;
var WAIT_TIME = 4000 ;
var ANIMATE_UNIT = 42 ;

function start_scroll()
{
	now_color = 0 ;
	setInterval( function() {
		scroll_element( "#photo_content" , { "speed_ratio" : 0.3 , "holdon_time" : 200 } ) ;
		scroll_element( "#poitag_content" , { "speed_ratio" : 0.4 , "holdon_time" : 0 } ) ;
		scroll_back_color( "#back_content" ) ;
	} , WAIT_TIME + SCROLL_TIME ) ;
}

function scroll_element( selector_str , options )
{
	var holdon_time = 0 , speed_ratio = 0.5 ;
	if ( options .holdon_time ) holdon_time = options .holdon_time ;
	if ( options .speed_ratio ) speed_ratio = options .speed_ratio ;

	$selector = $( selector_str ) ;
	var distance = $selector .width() ,
		T = SCROLL_TIME - holdon_time ,
		v_max = distance * 2.0 / T ;

	var $first_child = $selector .children() .eq( 0 ) ,
		$second_child = $selector .children() .eq( 1 ) ;

	$second_child .css( {
		"display" : "block" ,
		"left" : distance + "px" 
	} ) ;

	setTimeout( function() {
		var t = 0 ;
		var animate_interval = setInterval( function() {
			if ( t >= T )
			{
				$first_child .appendTo( selector_str ) ;
				$first_child .css( "display" , "none" ) ;
				$second_child .css( "left" , "0" ) ;
				clearInterval( animate_interval ) ;
				//setTimeout( function() { scroll( selector_str , options ) ; } , WAIT_TIME ) ;
			} else {
				var s ;
				if ( t < T * speed_ratio )
					s = ( v_max * t * t ) / ( 2 * T * speed_ratio ) ;
				else
					s = distance - ( ( T - t ) * ( T - t ) * v_max ) / ( 2 * T * ( 1 - speed_ratio ) ) ;
				//console.log( s + " " + distance ) ;

				$first_child .css( "left" , "-" + s + "px" ) ;
				$second_child .css( "left" , ( distance - s ) + "px" ) ;
				t += ANIMATE_UNIT ;
			}
		} , ANIMATE_UNIT ) ;
	} , holdon_time ) ;
}

function scroll_back_color( selector_str )
{
	var $selector = $( selector_str ) ;

	var $first_child = $selector .children() .eq( 0 ) ,
		$second_child = $selector .children() .eq( 1 ) ;
	$first_child .css( "z-index" , "6" ) ;
	$second_child .css( {
		"display" : "block" ,
		"z-index" : "4" ,
		"opacity" : "1.0"
	} ) ;

	var t = 0 ;
	var animate_interval = setInterval( function() {
		if ( t >= SCROLL_TIME )
		{
			$first_child .appendTo( selector_str ) ;
			$first_child .css( "display" , "none" ) ;
			clearInterval( animate_interval ) ;
		} else {
			$first_child .css( "opacity" , 1 - t / SCROLL_TIME ) ;
			t += ANIMATE_UNIT ;
		}
	} , ANIMATE_UNIT ) ;
}
