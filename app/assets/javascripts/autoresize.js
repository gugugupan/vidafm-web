function autoresize()
{
    var thumbnail = $(".thumbnail");
    for (var i = 0; i<$(".thumbnail").length; i++) {
        var ratioContainer = $(thumbnail[i]).height() / $(thumbnail[i]).width();
        var ratioPhoto = $(thumbnail[i]).find("img").height() / $(thumbnail[i]).find("img").width();

        if ( isNaN( ratioPhoto ) ) 
        {
            $(thumbnail[i]).find("img").css({"height":"auto"}).css({"width":"100%"});
            var y = 0 ;
            if ( $( thumbnail[ i ] ) .css( "width" ) == "500px" ) y = -100 ; else 
            if ( $( thumbnail[ i ] ) .css( "width" ) == "755px" ) y = -200 ; 
            $(thumbnail[i]).find("img").css({"margin-top":y});
        } else
        
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
    }
}
