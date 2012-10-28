#encoding: utf-8
class MiscController < ApplicationController
  
  def android_download
  end

  def index
    if request.url =~ /is_mobile=/i || request.user_agent =~ /(android|ipod|iphone)/i
      @is_ios = ( request.user_agent =~ /(ipod|iphone)/i )
      render "/misc/wap" , :layout => false
      return
    end

    @moments = Moment.hot_story() [ "data" ] [ "public_moments" ]
    @data = User.fetch_star_user( current_user ) [ "data" ]
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
    @message = JSON.parse( VIDA.call("/notification/list" , {} , current_user ) ) [ "data" ]
    @message[ "unread" ] .each { |n| n[ "sentence" ] = get_notification_sentence( n )  }
    @message[ "read" ] .each { |n| n[ "sentence" ] = get_notification_sentence( n )  }
    render "misc/notificationlist" , :layout => false 
  end

  def business
    render :layout => "application_nofooter"
  end

  def friend
    redirect_to "/" and return unless current_user
    @user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys
    @moment = User.fetch_friend_moments( current_user , 0 , 20 ) [ "data" ]
  end

  def ajax_get_new_page
    params[ :page ] = 1 if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1 ;
    @moment = User.fetch_friend_moments( current_user , params[ :page ] , 20 ) [ "data" ]
    render :layout => false 
  end
end
