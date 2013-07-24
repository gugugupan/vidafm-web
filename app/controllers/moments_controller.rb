#!/bin/env ruby
# encoding: utf-8
class MomentsController < ApplicationController
  def show

    #================added by chunlong.yu=========================
    ip = request.env["HTTP_X_FORWARDED_FOR"]

    Rails.logger.info "==========moment/show #{ip}================"
    Rails.logger.info "==========id: #{params[:id]}=========="
    Rails.logger.info "==========share_uid: #{params[:share_uid]}============"
    Rails.logger.info "==========create_uid: #{params[:create_uid]}============"
    Rails.logger.info "==========should_statistic: #{params[:should_statistic]}========"

    if Rails.cache.read(ip) == nil && ip != nil
        Rails.cache.write ip,"1"
        if params[:should_statistic] == true
          MomentStatistic.add_played_count(params[:id])
          UserStatisticTotal.add_shared_played_count(params[:share_uid])
          UserStatisticTotal.add_create_played_count(params[:create_uid])
        elsif params[:should_statistic] == nil 
          m = MomentStatistic.where(moment_id: params[:id]).first()
          if m != nil
            MomentStatistic.add_played_count(params[:id])
            UserStatisticTotal.add_create_played_count(m.user_id)
          end
        end
    end

    #data = Moment.fetch(params[ :id ] , current_user , :page => 0 , :page_size => 20 )
    data = api_call( "Moment" , :fetch , params[ :id ] , { :page => 0 , :page_size => 20 } )
    render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    redirect_to( user_url(data['data']['user_id']) , :notice => 401 ) and return if data[ 'result' ] == 401 
    @moment = data[ "data" ]

    # 对于 slideshow 的情况
    render "moments/slideshow" , :layout => "layouts/slideshow_layout" and return if params[ :md ] .nil?

    # 对于 momentshow 的情况
    @moment_cover = @moment[ "cover_file" ]
    @moment[ "haslocation" ] = get_haslocation( @moment[ "items" ] ) 

    activity_data = api_call( "Moment" , :fetch , nil , { :activity_id => notice , :page => 0 , :page_size => 1 } ) [ "data" ] [ "items" ] unless notice .nil?
    activity_data .each do | item |
      @activity = item if item[ 'id' ] == notice .to_i
    end unless notice .nil?

    save_url_in_cookies
  end

  def ajax_get_new_page
    return if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1
    @moment = Moment.fetch(params[ :id ] , current_user , :page => params[ :page ] , :page_size => 20 ) [ 'data' ] 
    render :layout => false
  end

  def comment
    if current_user
      @result = Comment.create( :comment_type => "Moment" , :type_id => params[ :id ] , :content => params[ :content ] , :user => current_user )
    else
      render "misc/need_authentication" , :locals => { :comment_box => "comment-block" }
    end
  end

  def allcomments 
    @comments = Comment.fetch( :type => "Moment" , :type_id => params[ :id ] ) [ "data" ]
  end

  def like
    if current_user 
      @result = Moment.like( params[:id ] , current_user , nil )
      if params[ :agent ] == "slideshow"
        render "likeslideshow"
      else 
        render "like"
      end
    else
      render "misc/need_authentication"
    end
  end

  def sharelist
    @sns_hash = {
      "weiboer" => { :name => "新浪微博" , :img => "icon/icon_sina.png" , :url_attr => "?type=weiboer" } ,
      "douban" => { :name => "豆瓣" , :img => "icon/icon_douban.png" , :url_attr => "?type=douban" } ,
      "renren" => { :name => "人人" , :img => "icon/icon_renren.png" , :url_attr => "?type=renren" } ,
      "kaixin001" => { :name => "开心" , :img => "icon/icon_kaixin.png" , :url_attr => "?type=kaixin001" } ,
      "qq-weibo" => { :name => "腾讯微博" , :img => "icon/icon_tencent.png" , :url_attr => "?type=qq-weibo" }
    }
    if current_user 
      @vendors = cur_user[ :vendors ]
    else
      render "misc/need_authentication"
    end
  end

  def share
    if current_user
      params[ :content ] += " http://vida.fm/moments/#{ params[ :id ] }"
      @result = Moment.share( current_user , :id => params[ :id ] , :type => params[ :type ] , :content => params[ :content ] )
    else
      render "misc/need_authentication"
    end
  end
  
  def rich
    #================added by chunlong.yu=========================
    ip = request.env["HTTP_X_FORWARDED_FOR"]
    
    Rails.logger.info "==========rich #{ip}================"
    Rails.logger.info "==========id: #{params[:id]}=========="
    Rails.logger.info "==========share_uid: #{params[:share_uid]}============"
    Rails.logger.info "==========create_uid: #{params[:create_uid]}============"
    Rails.logger.info "==========should_statistic: #{params[:should_statistic]}========"

    if Rails.cache.read(ip) == nil && ip != nil
        Rails.cache.write ip,"1"
        if params[:should_statistic] == true
          MomentStatistic.add_played_count(params[:id])
          UserStatisticTotal.add_shared_played_count(params[:share_uid])
          UserStatisticTotal.add_create_played_count(params[:create_uid])
        elsif params[:should_statistic] == nil 
          m = MomentStatistic.where(moment_id: params[:id]).first()
          if m != nil
            MomentStatistic.add_played_count(params[:id])
            UserStatisticTotal.add_create_played_count(m.user_id)
          end
        end
    end

    #id = params[:id]
    #@abc = id  
    
    #data = Moment.fetch(params[ :id ] , current_user , :page => 0 , :page_size => 20 )
    data = api_call( "Moment" , :fetch , params[ :id ] , { :page => 0 , :page_size => 20 } )
    render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    redirect_to( user_url(data['data']['user_id']) , :notice => 401 ) and return if data[ 'result' ] == 401 
    @moment = data[ "data" ]

    # 对于 slideshow 的情况
    # render "moments/slideshow" , :layout => "layouts/slideshow_layout" and return if params[ :md ] .nil?

    # 对于 momentshow 的情况
    @moment_cover = @moment[ "cover_file" ]
    @moment[ "haslocation" ] = get_haslocation( @moment[ "items" ] ) 

    activity_data = api_call( "Moment" , :fetch , nil , { :activity_id => notice , :page => 0 , :page_size => 1 } ) [ "data" ] [ "items" ] unless notice .nil?
    activity_data .each do | item |
      @activity = item if item[ 'id' ] == notice .to_i
    end unless notice .nil?

    save_url_in_cookies
    
    render :layout => "layouts/rich_layout"
  end
end
