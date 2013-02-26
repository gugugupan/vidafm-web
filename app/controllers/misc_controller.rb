#encoding: utf-8
class MiscController < ApplicationController
  
  def android_download
    @android_url = "http://zhushou.360.cn/detail/index/soft_id/4945?recrefer=SE_D_vida"
  end

  def index
    if request.url =~ /is_mobile=/i || request.user_agent =~ /(android|ipod|iphone)/i
      @is_ios = ( request.user_agent =~ /(ipod|iphone)/i )
      render "/misc/wap" , :layout => false
      return
    end

    @moments = api_call( "Moment" , :hot_story , nil , nil ) [ "data" ] [ "public_moments" ]
    @data = User.fetch_star_user( nil , current_user , nil ) [ "data" ]
    @data[ "recommended" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
    @data[ "stars" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
  end

  def about
  end

  def create_feedback
    response = Feedback.create( :from => params[ :from ] , :content => params[ :content ] )
    redirect_to :about, :notice => "感谢你的建议,我们将会尽快和你联系" if response['result'].to_i == 0
  end

  def ajax_notification
    session[ :cur_user ] [ :notification_count ] = 0
    @message = JSON.parse( VIDA.call("/notification/list" , {} , current_user ) [ :body ] ) [ "data" ]
    @message[ "unread" ] .each { |n| n[ "sentence" ] = get_notification_sentence( n )  }
    @message[ "read" ] .each { |n| n[ "sentence" ] = get_notification_sentence( n )  }
    render "misc/notificationlist" , :layout => false 
  end

  def business
    render :layout => "application_nofooter"
  end

  def friend
    redirect_to "/" and return unless current_user
    data = api_call( "User" , :fetch_feeds , 0 , {} ) [ "data" ]
    @moment = data[ "feeds" ] 
    @qparams = data[ "next_query_parameters" ] 

    save_url_in_cookies
  end

  def ajax_get_new_page
    next_query = {
      "activity_ids[before]" => params[ :activity ] ,
      "comment_ids[before]" => params[ :comment ] ,
      "like_ids[before]" => params[ :like ] 
    }
    data = User.fetch_feeds( nil , current_user , next_query ) [ "data" ]
    @feeds = data[ "feeds" ] 
    puts @feeds .to_json

    @qparams = data[ "next_query_parameters" ] 
    @qparams[ "activity_ids" ] = { "before" => params[ :activity ] } if @qparams[ "activity_ids" ] .nil?
    @qparams[ "comment_ids" ] = { "before" => params[ :comment ] } if @qparams[ "comment_ids" ] .nil?
    @qparams[ "like_ids" ] = { "before" => params[ :like ] } if @qparams[ "like_ids" ] .nil?

    render :layout => false 
  end
end
