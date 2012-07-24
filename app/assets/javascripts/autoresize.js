function autoresize()
{
    for (var i = 0; i<$(".thumbnail").length; i++) {
        var ratioContainer = $(thumbnail[i]).height() / $(thumbnail[i]).width();
        var ratioPhoto = $(thumbnail[i]).find("img").height() / $(thumbnail[i]).find("img").width();
        
        if (ratioPhoto == ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"100%"});

        } else if (ratioPhoto < ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"auto"});
            var x = -($(thumbnail[i]).find("img").width() - $(thumbnail[i]).width()) / 2;
            $(thumbnail[i]).find("img").css({"margin-left":x});

        } else if (ratioPhoto > ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"auto"}).css({"width":"100%"});
            var y = -($(thumbnail[i]).find("img").height() - $(thumbnail[i]).height()) / 2;
            $(thumbnail[i]).find("img").css({"margin-top":y});

        }
    };

/*
    $( ".show-photo" ) .each( function() {
        var pic_width = $( this ) .width() ;
        var doc_width = $( this ) .parent() .width() ;
        var pic_height = $( this ) .height() ;
        var doc_height = $( this ) .parent() .height() ;    

        $( this ) .parent() .css( "position" , "relative" ) ;
        $( this ) .css( "position" , "absolute" ) ;
        $( this ) .css( "top" , "0px" ) ;
        $( this ) .css( "right" , "0px" ) ;

        if ( doc_width <= pic_width ) 
        {
            if ( doc_height / pic_height > doc_width / pic_width )
            {
                $( this ) .css( "max-height" , "100%" ) ;
                pic_width = pic_width * ( doc_height / pic_height ) ;
                $( this ) .css( "right" , "-" + String( pic_width / 2 - doc_width / 2 ) + "px" ) ;
            } else
            {
                $( this ) .css( "max-width" , "100%" ) ;
                pic_height = pic_height * ( doc_width / pic_width ) ;
                $( this ) .css( "top" , "-" + String( pic_height / 2 - doc_height/ 2 ) + "px" ) ;
            }
        } else
        {
            $( this ) .css( "min-width" , "100%" ) ;
            pic_height = pic_height * ( doc_width / pic_width ) ;
            $( this ) .css( "top" , "-" + String( pic_height / 2 - doc_height/ 2 ) + "px" ) ;
        }
    });
*/
}

$( document ) .ready( function () {
    autoresize() ;
});
