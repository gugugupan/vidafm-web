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

    /*
     function slide(opt) {
     var el = opt.el;
     var time = opt.time;
     var x = opt.x;
     setTimeout(function(){
     el.css('backgroundPosition', x + "px 0");
     if (x == -1246) {
     opt.x = 178;
     }
     opt.x -= 178;
     slide(opt);
     }, time);
     }

     setTimeout(function(){
     var opt = {
     el: $("#clock"),
     time: 300,
     x: 0,
     type: -1
     };

     slide(opt);

     var a = setInterval(function() {
     if (opt.time <= 0) {
     opt.time = 350;
     }
     opt.time += opt.type * 50;
     }, 500);

     }, 1000);

     $("#clock").rotate({
     bind : {
     click : function() {
     var a = Math.floor(Math.random() * 360);
     a = 280;
     $(this).rotate({
     duration : 3000,
     angle : 0,
     animateTo : 1440 + a,
     //easing: $.easing.easeOutSine,
     callback : function() {
     //alert('中奖了！');
     }
     });
     }
     }
     });
     */

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