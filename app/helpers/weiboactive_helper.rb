module WeiboactiveHelper
    # 编辑推荐
    # 热门作品
    def createStory moments = [], col = 4
        
        $items = []
        $len = moments.length
        $raw = ($len/col).floor
        
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
                $items.push('<div class="' + $cls + '">')
                $items.push(render :partial => "widgets/wb_item" , :collection => Array[moments[col*i+j]] , :locals => { :show_type => "user" , :block_style => "block" }, :layout => nil)
                $items.push('</div>')
            }
            $items.push('</div>')
        }
        
        raw $items.join()
        
    end
end
