//= require bootstrap/bootstrap.min
//= require scrollup/jquery.scrollUp.min
//= require plugin/jQueryRotate.js

;$(function() {
    $.scrollUp({
        scrollName : 'scrollUp', // Element ID
        topDistance : 300, // Distance from top before showing element (px)
        topSpeed : 300, // Speed back to top (ms)
        animation : 'fade', // Fade, slide, none
        animationInSpeed : 200, // Animation in speed (ms)
        animationOutSpeed : 200, // Animation out speed (ms)
        scrollText : '', // Text for element
        scrollImg : false, // Set true to use image
        activeOverlay : false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
    });
    
    $("#scrollUp").css({'z-index': '1000'})
    
    /* SHARE MODAL DATA-API
     * ============== */

    $(document).on('click.sharemodal.data-api', '[data-toggle="share"]', function(e) {
        var $this = $(this), href = $this.attr('href'), $target = $("#modal-container-share")//strip for ie7
        , option = $target.data('modal') ? 'toggle' : $.extend({
            remote : !/#/.test(href) && href
        }, $target.data(), $this.data()), momentName = $this.attr("moment-name");
        
        $("#content", $target).val("我发现这个故事 #" + momentName +"# 很不错，特意分享 @Vida微达")

        e.preventDefault()

        $target.modal(option).one('hide', function() {
            $this.focus()
        })
    })
});

//抽奖
function rotate() {
    $("#clock").rotate({
        duration : 5000,
        angle : 10000,
        animateTo : 14400,
        //easing: $.easing.easeOutSine,
        callback : function() {
            //alert('中奖了！');
        }
    });
}