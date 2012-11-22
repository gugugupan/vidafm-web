function beginTheatre()
{
    $( "body" ) .css( "overflow" , "hidden" ) ;
    $( "#theatre" ) .css( "top" , $( window ) .scrollTop() ) ;
    $( "#theatre" ) .css( "width"  , $( window ) .width () ) ;
    $( "#theatre" ) .css( "height" , $( window ) .height() ) ;
    $( "#theatre" ) .fadeIn( 300 ) ;
}

function new_close_button( $insert_div )
{
    $insert_div .append( "<div id='close_button' class='mouse'> </div>" ) ;
    $insert_div .mouseover( function() { $( "#close_button" ) .fadeIn( 300 ) } ) ;
    $insert_div .mouseleave( function() { $( "#close_button" ) .fadeOut( 300 ) } ) ;
    $( "#close_button" ) .click( destroyTheatre ) ;
}

function destroyTheatre()
{
    $( "#theatre" ) .fadeOut( 500 ) ;
    setTimeout( function() { 
        $( "#theatre" ) .html( '<div class="theatre_blank"> </div>' ) ; 
        $( "body" ) .css( "overflow" , "scroll" ) ;
    } , 500 ) ;
}

function showMap( moment )
{
    var lat = 0 ;
    var lng = 0 ;
    for ( var i = 0 ; i < moment .items .length ; i ++ )
        if ( moment .items[ i ] .lat != 0 || moment .items[ i ] .lng != 0 )
        {
            lat = lat + moment .items[ i ] .lat ;
            lng = lng + moment .items[ i ] .lng ;
            break ;
        }

    if ( lat != 0 || lng != 0 )
    {
        var mapDiv = "<div id='map'> </div>"
        $( "#theatre" ) .prepend( mapDiv ) ;
        $( "#map" ) .css( "left" , ( $( window ) .width() - 800 ) / 2 ) ;
        beginTheatre() ;

        $( "#map" ) .click( function( event ) {
            event .stopPropagation() ;
        }) ;

        var options = {
            backgroundColor : "#BBBBBB" ,
            mapTypes : [G_NORMAL_MAP,G_SATELLITE_MAP] ,
            draggableCursor : "crosshair",
            draggingCursor : "move"
        };
        var map = new GMap2(document.getElementById("map"), options);
        var point = new GLatLng( lat , lng ) ;
        //var myMarker = new GMarker( point ) ;
        
        map .setCenter( point , 13 ) ;
        
        map .enableDragging() ;
        map .enableDoubleClickZoom() ;
        map .enableContinuousZoom() ;
        map .enableScrollWheelZoom() ;
        map .addControl( new GLargeMapControl() ) ;
        map .addControl( new GScaleControl() ) ;

        //map .addOverlay( myMarker ) ;

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
            var nMarker = new GMarker( npoint ) ;
            map .addOverlay( nMarker ) ;
        }
        new_close_button( $( "#map" ) ) ;
    }
}

function showAudio( audio )
{
    if ( soundManager.ok() ) 
    {
        $( "#audio" + audio .id + " .audio_button_black" ) .eq( 0 ) .fadeIn( 300 ) ;
        var audio_to_play = soundManager.createSound({
            id: audio .id ,
            url: audio .filename ,
            //url: "/789.m4a",
            onfinish: function() {
                /* finish callback */
                $( "#audio" + audio .id + " .audio_button_black" ) .eq( 0 ) .fadeOut( 300 ) ;
            } ,
            onfailure: function() {
                $( "#audio" + audio .id + " .audio_button_black" ) .eq( 0 ) .fadeOut( 300 ) ;
                showCenterBox( "声音播放错误." ) ;
            }
        });
        audio_to_play .play() ;
    } else
    {
        showCenterBox( "声音播放错误." ) ;
    }
}

function showActivityPhoto( activity )
{
    var imageDiv = "<div id=image_div> \
        <img src=" + activity .activity_url + " id='activity_detail_img'> \
        <div id='photo_black_cover'> </div> \
    </div>" ;
    $( "#theatre" ) .prepend( imageDiv ) ;
    $( "#activity_detail_img" ) .load( function() { 
        $( "#photo_black_cover" ) .css( "display" , "none" ) 
    }) ;
    $( "#activity_detail_img" ) .css( "max-width" , "1000px" ) ;
    $( "#activity_detail_img" ) .css( "height" , "auto" ) ;
    $( "#activity_detail_img" ) .css( "width" , "auto" ) ;
    $( "#image_div" ) .css( "width" , activity .img_width ) ;
    beginTheatre() ;
    $( "#theatre" ) .click( destroyTheatre ) ;

    new_close_button( $( "#image_div" ) ) ;

    if ( activity .audio != null ) showAudio( activity .audio ) ;
}

function showActivityVideo( video )
{
    if ( video .playable )
    {
        var videoDiv = '<video id="my_video_1" class="video-js vjs-default-skin"\
        controls preload="auto" width="648" height="648" poster="">\
            <source src="' + video .url_iphone + '" type="video/mp4">\
        </video>' ;

        $( "#theatre" ) .prepend( videoDiv ) ;
        beginTheatre() ;

        _V_("my_video_1", { "controls": true, "preload": "auto" }, function(){});
        $( "#my_video_1" ) .css( "left" , ( $( window ) .width() - 648 ) / 2 ) ;

        $( "#my_video_1" ) .append( "<div id='close_button' class='mouse'> </div>" ) ;
        $( "#close_button" ) .fadeIn( 0 ) ;
        $( "#close_button" ) .click( destroyTheatre ) ;
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
            $( "#notification_btn" ) .find( "span" ) .eq( 0 ) .text( "消息" ) ;
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
