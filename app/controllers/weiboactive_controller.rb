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
        @momentEditor = MomentStatistic.editor_recommended 0, 4

        #热门作品
        @momentHot = MomentStatistic.hot 0, 4

        #原创达人 Top10
        @createSortJson = UserStatisticTotal.create_sort 0, 10

        #分享达人 Top10
        @sharedSortJson = UserStatisticTotal.shared_sort 0, 10

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
        redirect_to action: 'index' and return unless params[ :id ]
        @profile_user = api_call( "User" , :fetch , params[ :id ] , current_user ) ["data"]
        redirect_to action: 'index' and return unless @profile_user
        save_url_in_cookies

        #我的作品
        @momentMyCreated = ShareMomentHistory.my_shared @profile_user["id"], 0, 12
        #我的分享
        @momentMyShared = ShareMomentHistory.my_shared @profile_user["id"], 0, 12

        unless @profile_user.nil?
            cur_user_static = UserStatisticTotal.my_profile @profile_user["id"]
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
        @momentEditor = MomentStatistic.editor_recommended 0, 12

        beforeRender
    end

    # 热门作品
    def hotstory
        save_url_in_cookies
        #热门作品
        @momentHot = MomentStatistic.hot 0, 12

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
            @noAwardSortJson = UserStatisticTotal.create_sort_without_award 0, 10
            #获奖排行榜
            @awardSortJson = UserStatisticTotal.create_award_history 0, 10
            @awardName = "iPad mini"
        else
        #去除获奖用户之后的排行榜
            @noAwardSortJson = UserStatisticTotal.shared_sort_without_award 0, 10
            #获奖排行榜
            @awardSortJson = UserStatisticTotal.shared_award_hitstory 0, 10
            @awardName = "Tiffany"
        end

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