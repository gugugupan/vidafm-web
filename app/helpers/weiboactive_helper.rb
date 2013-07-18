#encoding: utf-8
module WeiboactiveHelper
    # 编辑推荐
    # 热门作品
    def storyGallery moments = [], title = "", col = 4, raw = -1

        $items = []

        unless title == ""
            $items.push('<div class="row-fluid"><div class="span12"><div class="text-center block-title">' + title + '</div></div></div>')
        end

        $len = moments.length
        $raw = ($len.to_f/col.to_f).ceil

        $raw = [$raw, raw].min if raw != -1

        $items.push('<div class="row-fluid"><div class="span12 text-center">...</div></div>') if $raw == 0

        if col == 4
            $cls = "span3"
        elsif col == 3
            $cls = "span4"
        elsif col == 2
            $cls = "span6"
        end

        0.upto($raw-1) { |i|
            $items.push('<div class="row-fluid">')
            0.upto(col-1) { |j|
                break if col*i + j >= $len
                $items.push('<div class="' + $cls + '">')
                $items.push(render :partial => "widgets/wb_item" , :collection => Array[moments[col*i+j]] , :locals => { :show_type => "user" , :block_style => "block" }, :layout => nil)
                $items.push('</div>')
            }
            $items.push('</div>')
        }

        raw $items.join()

    end

    def shareLists
        @sns_hash = {
            "weiboer" => { :name => "新浪微博" , :img => "icon/icon_sina.png" , :url_attr => "?type=weiboer" } ,
            "douban" => { :name => "豆瓣" , :img => "icon/icon_douban.png" , :url_attr => "?type=douban" } ,
            "renren" => { :name => "人人" , :img => "icon/icon_renren.png" , :url_attr => "?type=renren" } ,
            "kaixin001" => { :name => "开心" , :img => "icon/icon_kaixin.png" , :url_attr => "?type=kaixin001" } ,
            "qq" => { :name => "腾讯微博" , :img => "icon/icon_tencent.png" , :url_attr => "?type=qq" }
        }
        if @cur_user
            @vendors = @cur_user[ :vendors ]
        else
            false
            #render "misc/need_authentication"
        end
    end

    # 是否绑定到腾讯微博分享
    def qqShareModal
        slists = shareLists
        sns_qq = false
        if slists.class.to_s == "Array"
            slists.each do |a|
                sns_qq = true if a["vendor"] == "qq-weibo"
            end
        end

        !!sns_qq
    end
end
