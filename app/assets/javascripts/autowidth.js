$( document ) .ready( function () {
    for ( var i = $( ".user-story" ) . length - 1 ; i >= 0 ; i -- )
    {
        if ( $( ".user-story:eq(" + i + ")" ) .find( ".thumbnail" ) .length == 1 ) 
        {
            $( ".user-story:eq(" + i + ")" ) .find( ".thumbnail" ) .css( "width" , "755px" ) ;
        } else
        if ( $( ".user-story:eq(" + i + ")" ) .find( ".thumbnail" ) .length == 2 ) 
        {
            $( ".user-story:eq(" + i + ")" ) .find( ".thumbnail:eq(0)" ) .css( "width" , "500px" ) ;
        }
    }

    if ( $( "#hidden-place" ) .length > 0 )
    {
        var sum = $( "#hidden-place" ) .children() .length ;
        while ( sum > 0 ) 
        {
            var rand = randomNumber( 6 ) + 1 ;
            var temp_div ;
            if ( rand == 1 && sum >= 1 )
            {
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .css( "width" , "1010px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story" ) ;
                sum -= 1 ;
            } else
            if ( rand == 2 && sum >= 2 )
            {
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .css( "width" , "755px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .appendTo( "#hot-story" ) ;
                sum -= 2 ;
            } else
            if ( rand == 3 && sum >= 3 )
            {
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 2 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 2 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "width" , "500px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .appendTo( "#hot-story" ) ;
                sum -= 3 ;
            } else
            if ( rand == 4 && sum >= 4 )
            {
                $( "#hot-story" ) .append( "<div style='width:510px'; id='insert-div'> </div>" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 3 ) .css( "width" , "500px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 3 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 2 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "width" , "500px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .appendTo( "#hot-story" ) ;
                sum -= 4 ;
            } else
            if ( rand == 5 && sum >= 5 )
            {
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 4 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 4 ) .css( "width" , "500px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 4 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 3 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 2 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .appendTo( "#hot-story" ) ;
                sum -= 5 ;
            } else
            if ( rand == 6 && sum >= 6 )
            {
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 5 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 5 ) .appendTo( "#hot-story" ) ;
                $( "#hot-story" ) .append( "<div style='width:510px'; id='insert-div'> </div>" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 4 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 3 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 2 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 1 ) .appendTo( "#hot-story div#insert-div:last-child" ) ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .css( "height" , "312px") ;
                $( "#hidden-place" ) .find( ".thumbnail") .eq( 0 ) .appendTo( "#hot-story" ) ;
                $( "#hot-story" ) .append( "<div class='clearfix'> </div>" ) ;
                sum -= 6 ;
            }
        }
    }
});