function centerImage(_box,_image){
    var boxRatio = _box.width() / _box.height();
    var imageRatio = _image.attr("cwidth") / _image.attr("cheight");
    if ( isNaN( imageRatio ) )
    {
        _image .css( { "width" : "100%" , "margin-top" : "-" + ( _box .height() / 3 ) + "px" } ) ;
    }else if (boxRatio > imageRatio) {
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
        _image.css({ "width" : "100%" });
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

var last_adjust_num = 0 ;
function adjust_image( callback )
{
    if ( $( "#feed_container" ) .attr( "blockstyle" ) == "block" )
    {
        for ( var i = last_adjust_num ; i < $( ".mlcontainer" ) .length ; i++ ) {
            var _boxObjects = $( ".mlcontainer:eq(" + i + ") .mlbox .image_box" ) ;
            var _imageObjects = $( ".mlcontainer:eq(" + i + ") .mlbox .image_box .mlimage img" );

            //image postion
            if ( _boxObjects .length == 1 ) 
            {
                var p = _boxObjects .width() / _imageObjects .attr( "cwidth" ) ;
                var new_height = _imageObjects .attr( "cheight" ) * p ;
                $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( new_height + "px" ) ;
                _imageObjects .css( {"height":"auto","width":"100%"} );
                //if ( i > 0 ) set_feed_height( i ) ;
            } else if( _boxObjects .length == 2 )
            {
                $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( "215px" ) ;
                _boxObjects .eq( 0 ) .addClass( "image_box_big" ) ;
                _boxObjects .eq( 1 ) .addClass( "image_box_middle" ) ;

                for( var y = 0 ; y < _imageObjects .length ; y++ )
                    centerImage( _boxObjects.eq( y ) ,_imageObjects .eq( y ) ) ;
                //if ( i > 0 ) set_feed_height( i ) ;
            } else 
            {
                $( ".mlcontainer:eq(" + i + ") .mlbox .image_container" ) .height( "215px" ) ;
                _boxObjects .eq( 0 ) .addClass( "image_box_big" ) ;
                _boxObjects .eq( 1 ) .addClass( "image_box_small" ) .css({"top":"5px"}) ;
                _boxObjects .eq( 2 ) .addClass( "image_box_small" ) ;

                for( var y = 0; y < _imageObjects .length ; y++ )
                    centerImage( _boxObjects .eq( y ) ,_imageObjects .eq( y ) ) ;
                //if ( i > 0 ) set_feed_height( i ) ;
            };

            if ( i == $( ".mlcontainer" ) .length - 1 ) callback() ;
        } ;
        last_adjust_num = $( ".mlcontainer" ) .length ;
    } else if ( $( "#feed_container" ) .attr( "blockstyle" ) == "puzzle" ) {
        if ( $( ".image_container_row" ) .length == 0 ) callback() ;
        for ( var i = last_adjust_num ; i < $( ".image_container_row" ) .length ; i ++ )
        {
            $row = $( ".image_container_row:eq(" + i + ")" ) ;
            //if ( $row .attr( "rebuild" ) == "true" ) break ;
            //$row .attr( "rebuild" , "true" ) ;

            if ( $row .find( ".image_box" ) .length == 1 )
            {
                var w = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cwidth" ) ,
                    h = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cheight" ) ;
                $row .height( 375 / w * h ) ;
                $row .find( ".image_box:eq(0)" ) .width( 375 ) ;
                $row .find( ".image_box:eq(0)" ) .height( 375 / w * h ) ;
                $row .find( ".mlimage" ) .css( "width" , "100%" ) ;
                $row .find( ".mlimage img" ) .css( "width" , "100%" ) ;
            }

            if ( $row .find( ".image_box" ) .length == 2 )
            {
                var w1 = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cwidth" ) , 
                    h1 = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cheight" ) , 
                    w2 = $row .find( ".image_box:eq(1) .mlimage img" ) .attr( "cwidth" ) , 
                    h2 = $row .find( ".image_box:eq(1) .mlimage img" ) .attr( "cheight" ) ;
                var h = Math .max( h1 , h2 ) ;
                w1 = w1 * h / h1 ;
                w2 = w2 * h / h2 ;
                var hh = 373 / ( w1 + w2 + 1 ) * h ;
                $row .height( hh ) ;
                w1 = w1 / h * hh ;
                w2 = w2 / h * hh ;
                $row .find( ".image_box:eq(0)" ) .width( w1 ) .height( hh ) ;
                $row .find( ".image_box:eq(1)" ) .width( w2 ) .height( hh ) .css( "margin-left" , "1px" ) ;
                $row .find( ".mlimage" ) .css( "width" , "100%" ) ;
                $row .find( ".mlimage img" ) .css( "width" , "100%" ) ;
            }

            if ( $row .find( ".image_box" ) .length == 3 )
            {
                var w1 = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cwidth" ) , 
                    h1 = $row .find( ".image_box:eq(0) .mlimage img" ) .attr( "cheight" ) , 
                    w2 = $row .find( ".image_box:eq(1) .mlimage img" ) .attr( "cwidth" ) , 
                    h2 = $row .find( ".image_box:eq(1) .mlimage img" ) .attr( "cheight" ) ,
                    w3 = $row .find( ".image_box:eq(2) .mlimage img" ) .attr( "cwidth" ) , 
                    h3 = $row .find( ".image_box:eq(2) .mlimage img" ) .attr( "cheight" ) ;
                var h = Math .max( h1 , h2 , h3 ) ;
                w1 = w1 * h / h1 ;
                w2 = w2 * h / h2 ;
                w3 = w3 * h / h3 ;
                var hh = 372 / ( w1 + w2 + w3 ) * h ;
                $row .height( hh ) ;
                w1 = w1 / h * hh ;
                w2 = w2 / h * hh ;
                w3 = w3 / h * hh ;
                $row .find( ".image_box:eq(0)" ) .width( w1 ) .height( hh ) ;
                $row .find( ".image_box:eq(1)" ) .width( w2 ) .height( hh ) .css( "margin-left" , "1px" ) ;
                $row .find( ".image_box:eq(2)" ) .width( w3 ) .height( hh ) .css( "margin-left" , "1px" ) ;
                $row .find( ".mlimage" ) .css( "width" , "100%" ) ;
                $row .find( ".mlimage img" ) .css( "width" , "100%" ) ;
            }

            if ( i == $( ".image_container_row" ) .length - 1 ) callback() ;
        }
        last_adjust_num = $( ".image_container_row" ) .length ;
    }

    // Arrange list_featured img
    for ( var i = 0 ; i < $( ".thumb" ) .length ; i ++ )
    {
        var $box_container = $( ".thumb" ) .eq( i ) ;
        centerImage( $box_container , $box_container .find( "img" ) .eq( 0 ) ) ;
    }
};

var left_px = 0 , right_px = 0 ;
var last_arrange_num = 0 ;
function arangeImage()
{
    adjust_image( function() {
        // If feeds dont need arange
        if ( $( "#feed_container" ) .attr( "dontarange" ) == "true" ) return ;

        // This function is using for make feed to left or right
        for ( var i = last_arrange_num ; i < $( ".feed" ) .length ; i ++ )
        {
            $feed = $( ".feed:eq(" + i + ")" ) ;
            if ( $feed .hasClass( "feed_left" ) || $feed .hasClass( "feed_right" ) ) continue ;
            if ( Math .abs( left_px - right_px ) < 30 )
            {
                if ( left_px < right_px )
                {
                    $feed .before( '<div class="feed feed_right empty_feed"> </div>' ) ;
                    right_px = 45 ;
                    left_px = 0 ;
                } else 
                {
                    $feed .before( '<div class="feed feed_left empty_feed"> </div>' ) ;
                    left_px = 45 ;
                    right_px = 0 ;
                }
                continue ;
            } else if ( left_px < right_px )
            {
                $feed .addClass( "feed_left" ) ;
                $feed .find( ".mlarrow_right" ) .eq( 0 ) .css( "display" , "block" ) ;
                $feed .find( ".feeds_icon_right" ) .eq( 0 ) .css( "display" , "block" ) ;
                left_px += 15 + $feed .height() ;
            } else 
            {
                $feed .addClass( "feed_right" ) ;
                $feed .find( ".mlarrow_left" ) .eq( 0 ) .css( "display" , "block" ) ;
                $feed .find( ".feeds_icon_left" ) .eq( 0 ) .css( "display" , "block" ) ;
                right_px += 15 + $feed .height() ;
            }
        }
        last_arrange_num = $( ".feed" ) .length ;
    } ) ;
}

var last_check_img ;
function repeat_check( callback )
{
    for ( var i = $( ".feed" ) .length - 1 ; i >= last_check_img ; i -- )
    {
        var need_delete = false ;
        var ith_feed_id = $( ".feed" ) .eq( i ) .attr( "id" ) ;
        for ( var j = 0 ; j < last_check_img ; j ++ )
            if ( ith_feed_id == $( ".feed" ) .eq( j ) .attr( "id" ) )
            {
                need_delete = true ;
                break ;
            }
        if ( need_delete ) $( ".feed" ) .eq( i ) .remove() ;
        if ( i == last_check_img ) callback() ;
    }
}
