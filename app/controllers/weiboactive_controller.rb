class WeiboactiveController < ApplicationController
    def initialize
        @avatars = [
            'http://pics.vida.fm/07bf7c8c-8120-11e2-a79a-180373f6dd13',
            'http://pics.vida.fm/e0df1638-e0fe-11e2-acf6-180373f6dd13',
            'http://pics.vida.fm/d9d5a0cc-9d70-11e2-bb82-180373f6dd13',
            'http://pics.vida.fm/d183a3cc-628a-11e2-8cd9-180373f6dd13',
            'http://pics.vida.fm/7ced847a-6412-11e2-92c5-180373f6dd13',
            'http://pics.vida.fm/0df73e00-627b-11e2-9378-180373f6dd13'
        ]

        @photos = [
            'http://pics.vida.fm/15/3111/2c14e390-dee7-11e2-8292-180373f6dd13_m',
            'http://pics.vida.fm/15/2611/e73797ec-db3d-11e2-8ca2-180373f6dd13_m',
            'http://pics.vida.fm/15/1911/d930a1fc-d50c-11e2-96f3-180373f6dd13_m',
            'http://pics.vida.fm/15/3411/9c9f7d3e-e0e3-11e2-b2ed-180373f6dd13_m',
            'http://pics.vida.fm/15/1310/f3498cd4-b847-11e2-9483-180373f6dd13_m',
            'http://pics.vida.fm/15/1711/979e541a-d3cb-11e2-8caf-180373f6dd13_m',
            'http://pics.vida.fm/14/3017/bddd57ce-4f60-11e2-943e-180373f6dd13_m',
            'http://pics.vida.fm/14/3314/107cd576-0a43-11e2-933f-180373f6dd13_m',
            'http://pics.vida.fm/14/1315/17de5f9c-11c3-11e2-8f7b-180373f6dd13_m'
        ]
    end

    def index
        save_url_in_cookies
        render :layout => "layouts/weiboactive_layout"
    end

    def myprofile
        render :layout => "layouts/weiboactive_layout"
    end

    def editorstory
        save_url_in_cookies
        render :layout => "layouts/weiboactive_layout"
    end

    def top
        save_url_in_cookies
        render :layout => "layouts/weiboactive_layout"
    end

    def rule
        save_url_in_cookies
        render :layout => "layouts/weiboactive_layout"
    end

    # 原创奖规则
    def rule_oa
        render :layout => "layouts/weiboactive_layout"
    end

    # 分享奖规则
    def rule_share
        render :layout => "layouts/weiboactive_layout"
    end

    # 抽奖
    def lottery
        # 未登录跳至首页
        redirect_to action: 'index' and return unless current_user
        render :layout => "layouts/weiboactive_layout"
    end
end
