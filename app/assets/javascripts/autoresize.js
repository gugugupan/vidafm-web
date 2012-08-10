function autoresize()
{
    var thumbnail = $(".thumbnail");
    for (var i = 0; i<$(".thumbnail").length; i++) {
        var ratioContainer = $(thumbnail[i]).height() / $(thumbnail[i]).width();
        var ratioPhoto = $(thumbnail[i]).find("img").attr("cheight") / $(thumbnail[i]).find("img").attr("cwidth");

        if (ratioPhoto == ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"100%"});

        } else if (ratioPhoto < ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"100%"}).css({"width":"auto"});
            var p = $(thumbnail[i]).height() / $(thumbnail[i]).find("img").attr("cheight") ;
            var new_width = $(thumbnail[i]).find("img").attr("cwidth") * p ;
            var x = -(new_width - $(thumbnail[i]).width()) / 2;
            $(thumbnail[i]).find("img").css({"margin-left":x});

        } else if (ratioPhoto > ratioContainer) {

            $(thumbnail[i]).find("img").css({"height":"auto"}).css({"width":"100%"});
            var p = $(thumbnail[i]).width() / $(thumbnail[i]).find("img").attr("cwidth"); ;
            var new_height = $(thumbnail[i]).find("img").attr("cheight") * p ;
            var y = -(new_height - $(thumbnail[i]).height()) / 2;
            $(thumbnail[i]).find("img").css({"margin-top":y});

        }
    }
}
