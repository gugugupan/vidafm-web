function centerImage(_box,_image){
    var boxRatio = _box.width() / _box.height();
    var imageRatio = _image.attr("cwidth") / _image.attr("cheight");

    if (boxRatio > imageRatio) {
        var p = _box.width() / _image.attr("cwidth") ; 
        var new_height = _image.attr("cheight") * p ;
        var y = ( _box.height() - new_height ) / 2;
        _image.width("100%");
        _image.css({ "margin-top" : y+"px" , "width" : "100%" });
    }else if(boxRatio < imageRatio){
        var p = _box.height() / _image.attr("cheight") ; 
        var new_width = _image.attr("cwidth") * p ;
        var x = ( _box.width() - new_width ) / 2;
        _image.css({ "margin-left" : x+"px" , "height" : "100%" });
    }else if(boxRatio == imageRatio) {
    };
};

function arangeImage(){
    //console.log("arangeImage");
    for (var i = 0; i < $(".mlcontainer").length; i++) {
        //console.log($(".mlcontainer").length);
        var _boxObjects = $(".mlcontainer:eq("+i+") .mlbox .image_box");
        var _imageObjects = $(".mlcontainer:eq("+i+") .mlbox .image_box .mlimage img");

        //image postion
        if ($(".mlcontainer:eq("+i+") .mlbox .image_box").length == 1) {
            //console.log("have 1 image");
            $(".mlcontainer:eq("+i+") .mlbox .image_box .mlimage img").css({"height":"auto","width":"100%"});
            //var x = (_boxObjects.width() - _imageObjects.width()) / 2;
            //_imageObjects.css({"margin-left":x+"px"});
        } else if($(".mlcontainer:eq("+i+") .mlbox .image_box").length == 2){
            //console.log("have 2 image");
            $(".mlcontainer:eq("+i+") .mlbox .image_container").height("214px");
            //$(".mlcontainer:eq("+i+") .mlinfo").css({"position":"absolute","bottom":"0px"});
            _boxObjects.eq(0).addClass("image_box_big");
            _boxObjects.eq(1).addClass("image_box_middle");

            for(var y = 0; y < _imageObjects.length; y++){
                centerImage($(".mlcontainer:eq("+i+") .mlbox .image_box").eq(y),_imageObjects.eq(y));
            }
        } else {
            //console.log("have 3 image");
            $(".mlcontainer:eq("+i+") .mlbox .image_container").height("215px");
            //$(".mlcontainer:eq("+i+") .mlinfo").css({"position":"absolute","bottom":"0px"});
            _boxObjects.eq(0).addClass("image_box_big");
            _boxObjects.eq(1).addClass("image_box_small").css({"top":"8px"});
            _boxObjects.eq(2).addClass("image_box_small");

            for(var y = 0; y < _imageObjects.length; y++){
                centerImage($(".mlcontainer:eq("+i+") .mlbox .image_box").eq(y),_imageObjects.eq(y));
            }
        };
    };
};
