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

    $("#scrollUp").css({
        'z-index' : '1000'
    });

    /* SHARE MODAL DATA-API
     * ============== */
    $(document).on('click.sharemodal.data-api', '[data-toggle="share"]', function(e) {
        e.preventDefault();
        var $this = $(this), href = $this.attr('href'), $target = $("#modal-container-share"), //strip for ie7
        //moment name
        momentName = $this.attr("moment-name"),
        //moment id
        momentId = $this.attr("moment-id"),
        //是否可以分享到腾讯微博
        sns_qq = $target.attr("sns-qq");

        $("#content", $target).val("我发现这个故事 #" + momentName + "# 很不错，特意分享 @Vida微达");
        if (String(sns_qq) == "true") {
            $.post("share?type=qq-weibo&id=" + momentId, $("form", $target).serialize()).done(function(data) {
                $("#lottery_btn").attr("coin", data.coin);
                $("#lottery_link").hide();
                $("#lottery_btn").removeAttr("disabled");
                $("#modal-container-lottery").modal().one('hide', function() {
                    $this.focus();
                });
                ;
            }).fail(function() {
                alert("程序出错,请稍候再抽");
            });
            return false;
        }

        $target.modal().one('hide', function() {
            $this.focus();
        });
    });
    /* PLAY MOMENT MODAL DATA-API
     * ============== */

    $(document).on('click.playmoment.data-api', '[data-toggle="play-moment"]', function(e) {
        var $this = $(this), momentId = $this.attr("moment-id");

        location.href = "/moments/" + momentId;

        e.preventDefault()

    });

    /* LOAD MORE DATA BUTTON
     * ============== */

    $(document).on('click.loadmore.data-api', '[data-toggle="load-more"]', function(e) {
        var $this = $(this), href = $this.attr('href'), page = Number($this.attr('data-current-page')), total = Number($this.attr('data-total-page'));

        e.preventDefault();
        if (page == total) {
            $this.text("已经没有更多了");
            return;
        }

        if (page + 1 <= total) {
            $this.attr('data-current-page', page + 1);
        }

        $.get(href, {
            page : page
        }).done(function(data) {
            if (page+1 == total) {
                $this.text("已经没有更多了");
            }
            $(data.data).insertBefore($this);
        });

    });

    /* pagination
     * ============== */
    $(document).on('click.pagination.data-api', '[data-toggle="pagination"]', function(e) {
        var $this = $(this), href = $this.attr('href'), page = Number($this.attr('data-current-page')), total = Number($this.attr('data-total-page')),
        toPage = Number($(e.target).attr("data-to-page")),
        type = $this.attr("data-type"),
        typeNum = $this.attr("data-type-num");
        
        e.preventDefault();
        if(isNaN(toPage))return;
        var arr = [
        '<li><a href="#" data-to-page="1">1</a></li>',
        '<li><span>...</span></li>',
        '<li class="active"><span>' + (toPage) + '</span></li>',
        '<li><a href="#" data-to-page="' + (toPage + 1)+ '">下一页</a></li>'
        ];
        if(toPage >= total){
            arr[3] = "<li><span>下一页</span></li>";
        }
        
        if (toPage == 1) {
            var str = arr[2] + arr[3];
        } else if(toPage == 2){
            var str = arr[0] + arr[2] + arr[3];
        } else if(toPage > 2){
            var str = arr.join("");
        }
        
        $this.html("<ul>" + str + "</ul>");
        
        $this.attr('data-current-page', toPage <= total ? toPage : total);
        
        $.get(href, {
            page : toPage,
            type: type,
            typeNum: typeNum
        }).done(function(data) {
            $(".talent-container", $this.parent()).html(data.data);
        });
    });

});

//抽奖
function rotate() {
    $.post("shuffle", $("form", $("#modal-container-lottery")).serialize());
    var coin = $("#lottery_btn").attr("coin");
    $("#lottery_btn").attr("disabled", "disabled");
    var animateTo = 0;

    if (coin == 1) {
        var random = Math.random();
        if (random < 0.33) {
            animateTo += 0;
        } else if (random < 0.66) {
            animateTo += 180;
        } else {
            animateTo += 270;
        }
    } else if (coin == 10) {
        animateTo += 90;
    } else {
        animateTo += 45;
    }

    $("#clock").rotate({
        duration : 5000,
        angle : 10000,
        animateTo : 14400 + animateTo,
        //easing: $.easing.easeOutSine,
        callback : function() {
            $("#lottery_btn").removeAttr("coin");
            if (animateTo != 45) {
                $("#lottery_link").show();
            }
        }
    });
}