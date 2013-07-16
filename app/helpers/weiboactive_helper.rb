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
end
