#encoding: utf-8
class WeiboactiveController < ApplicationController
    def initialize
    end

    def beforeRender
        check_user_agent
    end

    # check user agent version
    def check_user_agent
        @mobile = !!(request.user_agent =~ /iphone|ipod|blackberry|windows\sce|palm|smartphone|mobile/i)
        unless @mobile == true
            render :layout => "layouts/weiboactive_layout"
        else
            render :layout => "layouts/weiboactive_mobile_layout"
        end
    end

    #首页
    def index
        save_url_in_cookies
        unless request.env['REMOTE_ADDR'] == "127.0.0.1"
            File.open("user_agent.txt", "a+") do |f|
                f.write(request.env['REMOTE_ADDR'] + " ::: " + request.user_agent + "\n")
            end
        end
        #今日iPad mini得主
        @ipadTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:1).order("`award_time` desc").first
        @user0 = @ipadTodayUser.nil? ? nil : User.fetch(@ipadTodayUser[:user_id].to_s, current_user, nil)["data"]
        #今日Tiffany得主
        @tiffanyTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:2).order("`award_time` desc").first
        @user1 = @tiffanyTodayUser.nil? ? nil : User.fetch(@tiffanyTodayUser[:user_id].to_s, current_user, nil)["data"]

        #编辑推荐
        @momentEditorRecords = MomentStatistic.editor_recommended 4, 0
        @momentEditor = @momentEditorRecords && @momentEditorRecords.length >= 1 ? JSON.parse(@momentEditorRecords.to_json) : Array.new

        @momentEditor.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentEditor.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        #热门作品
        @momentHotRecords = MomentStatistic.hot 0
        @momentHot = @momentHotRecords && @momentHotRecords.length >= 1 ? JSON.parse(@momentHotRecords.to_json) : Array.new

        @momentHot.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentHot.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        #原创达人 Top10
        @createSort = UserStatisticTotal.create_sort 0
        #分享达人 Top10
        @sharedSort = UserStatisticTotal.shared_sort 0

        @createSortJson = @createSort && @createSort.length >= 1 ? JSON.parse(@createSort.to_json) : Array.new
        @sharedSortJson = @sharedSort && @sharedSort.length >= 1 ? JSON.parse(@sharedSort.to_json) : Array.new

        @createSortJson.each do |a|
            u = User.fetch a["user_id"].to_s, current_user, nil
            #u = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/user0.json"), "rb").read)
            a["user"] = u[ "data" ] unless u.nil?
        end

        @createSortJson.delete_if {|i| i["user"].nil?}

        @sharedSortJson.each do |a|
            u = User.fetch a["user_id"].to_s, current_user, nil
            #u = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/user1.json"), "rb").read)
            a["user"] = u[ "data" ] unless u.nil?
        end

        @sharedSortJson.delete_if {|i| i["user"].nil?}

        unless current_user.nil?
            cur_user_static = UserStatisticTotal.my_profile current_user["id"]

            @currCreateScore = cur_user_static[0]
            @currShareScore = cur_user_static[1]
        else
            @currCreateScore = 0
            @currShareScore = 0
        end

        beforeRender
    end

    # 我的页面
    def myprofile
        # 未登录跳至首页
        redirect_to action: 'index' and return unless current_user
        save_url_in_cookies
        #我的作品
        @momentMyCreatedRecords = ShareMomentHistory.my_shared current_user["id"], 0
        @momentMyCreated = @momentMyCreatedRecords && @momentMyCreatedRecords.length >= 1 ? JSON.parse(@momentMyCreatedRecords.to_json) : Array.new

        @momentMyCreated.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentMyCreated.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        #我的分享
        @momentMySharedRecords = ShareMomentHistory.my_shared current_user["id"], 0
        @momentMyShared = @momentMySharedRecords && @momentMySharedRecords.length >= 1 ? JSON.parse(@momentMySharedRecords.to_json) : Array.new

        @momentMyShared.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentMyShared.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        unless current_user.nil?
            cur_user_static = UserStatisticTotal.my_profile current_user["id"]
            @currCreateScore = cur_user_static[0]
            @currShareScore = cur_user_static[1]
            @create_rank = cur_user_static[2]
            @share_rank = cur_user_static[3]
        else
            @currCreateScore = 0
            @currShareScore = 0
            @create_rank = "--"
            @share_rank = "--"
        end

        beforeRender
    end

    #编辑推荐
    def editorstory
        save_url_in_cookies
        @momentEditorRecords = MomentStatistic.editor_recommended 12, 0
        @momentEditor = @momentEditorRecords && @momentEditorRecords.length >= 1 ? JSON.parse(@momentEditorRecords.to_json) : Array.new

        @momentEditor.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentEditor.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        beforeRender
    end

    # 热门作品
    def hotstory
        save_url_in_cookies
        #热门作品
        @momentHotRecords = MomentStatistic.hot 0
        @momentHot = @momentHotRecords && @momentHotRecords.length >= 1 ? JSON.parse(@momentHotRecords.to_json) : Array.new

        @momentHot.each do |a|
            m = Moment.fetch a["moment_id"], current_user
            a.merge! m["data"] unless m["data"].nil?
        end
        @momentHot.delete_if {|i| i["items"].nil? || i["items"].length == 0}

        beforeRender
    end

    def top
        redirect_to action: 'index' and return unless params[:type]
        save_url_in_cookies
        @showType = params[:type]
        @title = params[:type] == "create" ? "原创达人" : "分享达人"

        #今日iPad mini得主
        @ipadTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:1).order("`award_time` desc").first
        @user0 = @ipadTodayUser.nil? ? nil : User.fetch(@ipadTodayUser[:user_id].to_s, current_user, nil)["data"]
        #今日Tiffany得主
        @tiffanyTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:2).order("`award_time` desc").first
        @user1 = @tiffanyTodayUser.nil? ? nil : User.fetch(@tiffanyTodayUser[:user_id].to_s, current_user, nil)["data"]

        if params[:type] == "create"
            #去除获奖用户之后的排行榜
            @noAwardSort = UserStatisticTotal.create_sort_without_award 0
            #获奖排行榜
            @awardSort = UserStatisticTotal.create_award_history 0
            @awardName = "iPad mini"
        else
        #去除获奖用户之后的排行榜
            @noAwardSort = UserStatisticTotal.shared_sort_without_award 0
            #获奖排行榜
            @awardSort = UserStatisticTotal.shared_award_hitstory 0
            @awardName = "Tiffany"
        end

        @noAwardSortJson = @noAwardSort && @noAwardSort.length >= 1 ? JSON.parse(@noAwardSort.to_json) : Array.new
        @awardSortJson = @awardSort && @awardSort.length >= 1 ? JSON.parse(@awardSort.to_json) : Array.new

        @noAwardSortJson.each do |a|
            u = User.fetch a["user_id"].to_s, current_user, nil
            #u = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/user0.json"), "rb").read)
            a["user"] = u[ "data" ] unless u.nil?
        end

        @noAwardSortJson.delete_if {|i| i["user"].nil?}

        @awardSortJson.each do |a|
            u = User.fetch a["user_id"].to_s, current_user, nil
            #u = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/user1.json"), "rb").read)
            a["user"] = u[ "data" ] unless u.nil?
        end

        @awardSortJson.delete_if {|i| i["user"].nil?}
        beforeRender
    end

    def rule
        save_url_in_cookies
        beforeRender
    end

    # 原创奖规则
    def rule_oa
        save_url_in_cookies
        beforeRender
    end

    # 分享奖规则
    def rule_share
        save_url_in_cookies
        beforeRender
    end

    # 抽奖
    def lottery
        # 未登录跳至首页
        redirect_to action: 'index' and return unless current_user

        @list_qq_coins = UserShuffle.list_qq_coins current_user["id"]

        beforeRender
    end

    # 分享
    def share
        result = '{"result":1, "message": "请登录"}'
        if current_user
            params[ :content ] += " http://vida.fm/moments/#{ params[ :id ] }"
            @result = Moment.share( current_user , :id => params[ :id ] , :type => params[ :type ] , :content => params[ :content ] )

            @result["coin"] = UserShuffle.get_qq_coin current_user["id"], session

        result = @result.to_json
        end

        respond_to do |format|
            format.json { render :json => result }
        end
    end

    # 领取抽奖
    def shuffle
        result = '{"result":1, "message": "请登录"}'
        if current_user
            UserShuffle.shuffle current_user["id"], session
            result = '{"result":0, "message": "抽奖成功"}'
        end
        respond_to do |format|
            format.json { render :json => result }
        end
    end
end