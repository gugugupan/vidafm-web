#encoding: utf-8
class WeiboactiveController < ApplicationController
    def initialize
    end

    # check user agent version
    def check_user_agent
        if request.user_agent =~ /(android|ipod|iphone)/i
            @mobile = true
            render :layout => "layouts/weiboactive_mobile_layout"
        else
            @mobile = false
            render :layout => "layouts/weiboactive_layout"
        end
    end

    #首页
    def index
        save_url_in_cookies

        #今日iPad mini得主
        @ipadTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:1).order("`award_time` desc").first
        @user0 = @ipadTodayUser.nil? ? nil : User.fetch(@ipadTodayUser[:user_id].to_s, current_user, nil)["data"]
        #今日Tiffany得主
        @tiffanyTodayUser = UserStatisticTotal.where(is_award:1).where(award_type:2).order("`award_time` desc").first
        @user1 = @tiffanyTodayUser.nil? ? nil : User.fetch(@tiffanyTodayUser[:user_id].to_s, current_user, nil)["data"]

        #TODO::编辑推荐
        @moment = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/moments.json"), "rb").read)[ "data" ] [ "moments" ]
        #@momentHot = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/moments.json"), "rb").read)[ "data" ] [ "moments" ]

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
        
        cur_user_static = current_user.nil? ? nil : UserStatisticTotal.where(user_id: current_user["id"]).first
        @currCreateScore = cur_user_static.nil? ? 0 : cur_user_static[:create_score]
        @currShareScore = cur_user_static.nil? ? 0 : cur_user_static[:share_score]

        check_user_agent
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

        cur_user_static = current_user.nil? ? nil : UserStatisticTotal.where(user_id: current_user["id"]).first
        @currCreateScore = cur_user_static.nil? ? 0 : cur_user_static[:create_score]
        @currShareScore = cur_user_static.nil? ? 0 : cur_user_static[:share_score]

        check_user_agent
    end

    #编辑推荐
    def editorstory
        save_url_in_cookies
        @moment = JSON.parse(File.open(File.join(File.expand_path(File.dirname(__FILE__)), "../assets/json/moments.json"), "rb").read)[ "data" ] [ "moments" ]

        check_user_agent
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

        check_user_agent
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
        check_user_agent
    end

    def rule
        save_url_in_cookies
        check_user_agent
    end

    # 原创奖规则
    def rule_oa
        save_url_in_cookies
        check_user_agent
    end

    # 分享奖规则
    def rule_share
        save_url_in_cookies
        check_user_agent
    end

    # 抽奖
    def lottery
        # 未登录跳至首页
        redirect_to action: 'index' and return unless current_user
        check_user_agent
    end
end