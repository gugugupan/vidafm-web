function autoWidthPhoto()
{
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
        if ( i == 0 )
            autoresize() ;
    }
}
