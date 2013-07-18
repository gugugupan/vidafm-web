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

    # { :class => "" , :style => "" }
    def avatar_tag_weiboactive user , options = {}
        user[ "avatar_file" ] = user[ :avatar_file ] if user[ "avatar_file" ] .nil?
        user[ "id" ] = user[ :id ] if user[ "id" ] .nil?
        user[ "name" ] = user[ :name ] if user[ "name" ] .nil?
        inner_html = link_to( "" , {:controller => "weiboactive",:action => "myprofile", :id => user[ "id" ]} , 
            :class => "avatar #{ options[ :class ] }" , 
            :style => "background-image:url('#{ user[ "avatar_file" ] }');
                    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='#{ user[ "avatar_file" ] }',sizingMethod='scale');" , # hack for ie
            :title => user[ "name" ] )
        raw inner_html
    end
    
    def avatar_tag_weiboactive_big user, options = {}
        user.symbolize_keys!
        class_str = "avatar #{ options[ :class ] }"
        if options[ :nolink ].nil?
          inner_html = link_to( image_tag( user[ :avatar_file ] ) , {:controller => "weiboactive",:action => "myprofile", :id => user[ :id ]} , 
            :class => class_str , 
            :title => user[ :name ])
        else
          inner_html = image_tag( user[ :avatar_file ] , :class => options[ :class ] || 'avatar' ) if options[ :nolink ]
        end
        raw inner_html
    end

end
