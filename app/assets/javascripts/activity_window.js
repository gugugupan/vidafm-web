function showMap( moment )
{
    var lat = moment .lat ;
    var lng = moment .lng ;
    if ( lat != 0 || lng != 0 )
    {
        var showDiv = "<div class='need_destroy' id='activity_detail'> </div>" ;
        var mapDiv = "<div id='map'> </div>"
        $( "body" ) .append( showDiv ) ;
        $( "#activity_detail" ) .append( mapDiv ) ;
        $( "#activity_detail" ) .css( "width"  , $( document ) .width () ) ;
        $( "#activity_detail" ) .css( "height" , $( document ) .height() ) ;
        $( "#map" ) .css( "left" , ( $( window ) .width() - 800 ) / 2 ) ;
        $( "#map" ) .css( "top" , $( window ) .height() * 0.025 + $( window ) .scrollTop() ) ;
        $( "#activity_detail" ) .fadeIn( 1000 ) ;

        $( "#activity_detail" ) .click( function() {
            destroyDialog( 1 ) ;
        }) ;
        $( "#map" ) .click( function( event ) {
            event .stopPropagation() ;
        }) ;

        var options = {
            size : GSize(lat, lng) , 
            backgroundColor : "#BBBBBB" ,
            mapTypes : [G_NORMAL_MAP,G_SATELLITE_MAP] ,
            draggableCursor : "crosshair",
            draggingCursor : "move"
        };
        var map = new GMap2(document.getElementById("map"), options);
        var point = new GLatLng( lat , lng ) ;
        var myMarker = new GMarker( point ) ;
        
        map .setCenter( point , 13 ) ;
        map .enableDragging() ;
        map .enableDoubleClickZoom() ;
        map .enableContinuousZoom() ;
        map .enableScrollWheelZoom() ;
        map .addControl( new GLargeMapControl() ) ;
        map .addControl( new GMapTypeControl() ) ;
        map .addControl( new GScaleControl() ) ;
        map .addOverlay( myMarker ) ;

        for ( var i = 0 ; i < moment .items .length ; i ++ )
        {
            var nlat = moment .items[ i ] .lat ;
            var nlng = moment .items[ i ] .lng ;
            var nIcon = new GIcon( { image : moment .items[ i ] .photo .url_s , 
                                     iconAnchor : new GPoint( 50 , 50 ) , 
                                     iconSize : new GSize( 100 , 100 ) 
                                 } ) ;
            if ( nlat == 0 && nlng == 0 ) continue ;
            var npoint = new GLatLng( nlat , nlng ) ;
            var nMarker = new GMarker( npoint , nIcon ) ;
            map .addOverlay( nMarker ) ;
        }
    }
}

function showActivityPhoto( activity_url , img_width )
{
    if ( $( "#activity_detail" ) .length == 0 ) 
    {
        var showDiv = "<div class='need_destroy' id='activity_detail'> </div>" ;
        var imageDiv = "<img src=" + activity_url + " id='activity_detail_img'>" ;
        $( "body" ) .append( showDiv ) ;
        $( "#activity_detail" ) .append( imageDiv ) ;
        $( "#activity_detail" ) .css( "width"  , $( document ) .width () ) ;
        $( "#activity_detail" ) .css( "height" , $( document ) .height() ) ;
        $( "#activity_detail_img" ) .css( "height" , "auto" ) ;
        $( "#activity_detail_img" ) .css( "width" , "auto" ) ;
        $( "#activity_detail_img" ) .css( "left" , ( $( window ) .width() - img_width ) / 2 ) ;
        $( "#activity_detail_img" ) .css( "top" , $( window ) .height() * 0.05 + $( window ) .scrollTop() ) ;
        $( "#activity_detail" ) .fadeIn( 300 ) ;

        $( "#activity_detail" ) .click( function() {
            destroyDialog( 1 ) ;
        }) ;
    }
}

function showActivityVideo( video )
{
    if ( video .playable )
    {
        var showDiv = "<div class='need_destroy' id='activity_detail'> </div>" ;
        var videoDiv = '<video id="my_video_1" class="video-js vjs-default-skin"\
        controls preload="auto" width="648" height="648" poster="">\
            <source src="' + video .url_iphone + '" type="video/mp4">\
        </video>' ;

        $( "body" ) .append( showDiv ) ;
        $( "#activity_detail" ) .append( videoDiv ) ;
        $( "#activity_detail" ) .css( "width"  , $( document ) .width () ) ;
        $( "#activity_detail" ) .css( "height" , $( document ) .height() ) ;
        $( "#activity_detail" ) .fadeIn( 300 ) ;

        _V_("my_video_1", { "controls": true, "preload": "auto" }, function(){
        });

        $( "#my_video_1" ) .css( "left" , ( $( window ) .width() - 648 ) / 2 ) ;
        $( "#my_video_1" ) .css( "top" , $( window ) .height() * 0.05 + $( window ) .scrollTop() ) ;

        $( "#activity_detail" ) .click( function() {
            destroyDialog( 1 ) ;
        }) ;
        $( "#my_video_1" ) .click( function( event ) {
            event .stopPropagation() ;
        }) ;
    } else
    {
        showCenterBox( "视频处理中,请稍后再试." ) ;
    }
}


function callNotificationBox()
{
    var blackDiv = "<div id='message_box' class='black_background need_destroy'>\
        <div id='message' class='popup_container'>\
            <p class='content'> 读取中.. </p>\
        </div>\
    </div>" ;
    if ( $( "#message_box" ) .length == 0 )
    {
        $( "body" ) .append( blackDiv ) ;
        $( "#message_box" ) .css( "width"  , $( document ) .width () ) ;
        $( "#message_box" ) .css( "height" , $( document ) .height() ) ;
        $( "#message_box" ) .fadeIn( 500 ) ;
        $.get( "/ajax_notification" , function( getData ) {
            $( "#message_box" ) .empty() ;
            $( "#message_box" ) .append( getData ) ;
            avatarShow() ;

            $( "#message_box" ) .click( function() {
                destroyDialog( 1 ) ;
            }) ;
            $( "#message" ) .click( function( event ) {
                event .stopPropagation() ;
            }) ;
        }) ;
    }
}