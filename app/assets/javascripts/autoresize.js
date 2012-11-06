function centerImage(_box,_image){
    var boxRatio = _box.width() / _box.height();
    var imageRatio = _image.attr("cwidth") / _image.attr("cheight");

    if (boxRatio > imageRatio) {
        var p = _box.width() / _image.attr("cwidth") ; 
        var new_height = _image.attr("cheight") * p ;
        var y = ( _box.height() - new_height ) / 2;
        _image.css({ "margin-top" : y+"px" , "width" : "100%" });
    }else if(boxRatio < imageRatio){
        var p = _box.height() / _image.attr("cheight") ; 
        var new_width = _image.attr("cwidth") * p ;
        var x = ( _box.width() - new_width ) / 2;
        _image.css({ "margin-left" : x+"px" , "height" : "100%" });
    }else if(boxRatio == imageRatio) {
    };
};

function set_feed_height( i )
{
    var _feed = $( ".feed:eq("+i+")") ;
    var _last_feed = $( ".feed:eq("+( i - 1 ) +")") ;
    var s = _last_feed .css( "margin-top" ) ;
    var x = Number( s .substring( 0 , s .length - 2 ) ) ;
    var move = Math .min( _last_feed .height() - 86 , _last_feed .height() + x ) ;
    if ( move > 0 ) move = -move ; else move = 0 ;
    _feed .css( { "margin-top" : move + "px" } ) ;
}

function arangeImage(){
    //console.log("arangeImage");
    for ( var i = 0; i < $( ".mlcontainer" ) .length ; i++ ) {
        //console.log($(".mlcontainer").length);
        var _boxObjects = $( ".mlcontainer:eq(" + i + ") .mlbox .image_box" ) ;
        var _imageObjects = $( ".mlcontainer:eq(" + i + ") .mlbox .image_box .mlimage img" );
        var first_part_done = false ;

        //image postion
        if ( _boxObjects .length == 1 ) 
        {
            var p = _boxObjects .width() / _imageObjects .attr( "cwidth" ) ;
            var new_height = _imageObjects .attr( "cheight" ) * p ;
            $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( new_height + "px" ) ;
            _imageObjects .css( {"height":"auto","width":"100%"} );
            if ( i > 0 ) set_feed_height( i ) ;
        } else if( _boxObjects .length == 2 )
        {
            $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( "215px" ) ;
            _boxObjects .eq( 0 ) .addClass( "image_box_big" ) ;
            _boxObjects .eq( 1 ) .addClass( "image_box_middle" ) ;

            for( var y = 0 ; y < _imageObjects .length ; y++ )
                centerImage( _boxObjects.eq( y ) ,_imageObjects .eq( y ) ) ;
            if ( i > 0 ) set_feed_height( i ) ;
        } else 
        {
            $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( "215px" ) ;
            _boxObjects .eq( 0 ) .addClass( "image_box_big" ) ;
            _boxObjects .eq( 1 ) .addClass( "image_box_small" ) .css({"top":"8px"}) ;
            _boxObjects .eq( 2 ) .addClass( "image_box_small" ) ;

            for( var y = 0; y < _imageObjects .length ; y++ )
                centerImage( $( ".mlcontainer:eq(" + i + ") .mlbox .image_box" ) .eq( y ) ,_imageObjects .eq( y ) ) ;
            if ( i > 0 ) set_feed_height( i ) ;
        };
    };
};

function repeat_check( callback )
{
    for ( var i = $( ".feed" ) .length - 1 ; i >= 0 ; i -- ) 
    {
        var check_flag = false ;
        var _boxObjects = $( ".feed:eq(" + i + ")" ) ;
        var id_i = _boxObjects .attr( "id" ) ;
        for ( var j = i - 1 ; j >= 0 ; j -- )
            if ( id_i == $( ".feed:eq(" + j + ")" ) .attr( "id" ) )
            {
                check_flag = true ;
                break ;
            }
        if ( check_flag ) _boxObjects .remove() ;
        if ( i == 0 ) callback() ;
    }
}
