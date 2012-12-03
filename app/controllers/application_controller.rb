#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user , :cur_user
  # before_filter :record_browse_histories if Rails.env.production?

  # def record_browse_histories
  #   b = BrowseHistory.new
  #   b.uu_user_id = uu_user_id
  #   b.user_id = session[:current_user]['id'] if session[:current_user].present?
  #   b.referer = request.referer.slice(0, 350) if !request.referer.blank?
  #   b.agent = request.user_agent.slice(0, 480) if !request.user_agent.blank?
  #   b.url = request.fullpath.slice(0, 350) if !request.fullpath.blank?
  #   if !params.blank?
  #     b.params = params[:id]
  #   end
  #   b.ip = request.remote_ip
  #   b.save    
  # end

  def uu_user_id
    cookies.permanent[:uu_user_id] = nonce if cookies[:uu_user_id].nil?
    cookies[:uu_user_id]
  end

  def current_user
    return nil unless session[:current_user]
    # 不知道为何有时候keys会变成symbol，这里做个hack
    @current_user = session[:current_user].stringify_keys!
  end

  def cur_user
    return nil unless session[ :current_user ]
    unless session[ :cur_user ] .nil?
      @cur_user = session[ :cur_user ]
    else
      data = User.fetch_current_user( current_user ) [ "data" ]
      session[ :cur_user ] = { 
        :id => data[ "id" ] , 
        :avatar_file => data[ "avatar_file" ] , 
        :name => data[ "name" ] ,
        :vendors => data[ "vendors" ] ,
        :notification_count => data[ "notification_count" ] 
      }
      @cur_user = session[ :cur_user ] 
    end
  end

  def save_url_in_cookies
    cookies[:refer_url] = request.url
  end

  private

  def nonce
    rand(10 ** 30).to_s.rjust(30,'0')
  end


  def auth_failed(json_data)
    (json_data['result'] || json_data[:result]).to_i == 401
  end
  
  def get_relation_btn( r )
    alph = {
      "none" => 0 , "followed_by" => 0 , "pending_approve" => 0 , "pending_ignore" => 0 , "suggest_follow" => 0 ,
      "following" => 1 , "favourite" => 1 , "two_way_following" => 1 ,
      "pending" => 2
    }
    return alph[ r ]
  end

  def get_haslocation( item )
    for a in item
      return true if ( a[ 'lat' ] != 0 && a[ 'lng' ] != 0 )
    end
    return false 
  end

  def get_notification_sentence( noti )
    unless {2,2,3,3,4,4,9,9,10,10,12,12} [ noti[ "notification_type" ] ] .nil?
      if noti[ 'moment' ][ "category" ] = "random" and noti[ 'moment' ][ "name" ] .empty?
        noti[ 'moment' ][ "name" ] = "#{ noti[ 'moment' ][ 'created_at' ] [ 5 , 2 ] }月#{ noti[ 'moment' ][ 'created_at' ] [ 8 , 2 ]}日随拍" 
      end
    end

    if noti[ "notification_type" ] == 1 
      return "喜欢您的照片" if noti[ "activity" ] [ "activity_type" ] == 1 ;
      return "喜欢您的视频" if noti[ "activity" ] [ "activity_type" ] == 3 ;
    end
    if noti[ "notification_type" ] == 2
      return "在您的活动 #{ noti[ 'moment' ] [ 'name' ] } 中添加了照片"  if noti[ "activity" ] [ "activity_type" ] == 1 ;
      return "在您的活动 #{ noti[ 'moment' ] [ 'name' ] } 中添加了视频"  if noti[ "activity" ] [ "activity_type" ] == 3 ;
    end 
    return "在您附近添加了活动 #{ noti[ 'moment' ] [ 'name' ] }" if noti[ "notification_type" ] == 3 
    if noti[ "notification_type" ] == 4
      return "移除了您在活动 #{ noti[ 'moment' ] [ 'name' ] } 中的照片"  if noti[ "activity" ] [ "activity_type" ] == 1 ;
      return "移除了您在活动 #{ noti[ 'moment' ] [ 'name' ] } 中的视频"  if noti[ "activity" ] [ "activity_type" ] == 3 ;
    end 
    if noti[ "notification_type" ] == 5 
      return "在照片中提到了您" if noti[ "activity" ] [ "activity_type" ] == 1 ;
      return "在视频中提到了您" if noti[ "activity" ] [ "activity_type" ] == 1 ;
    end 
    return "在评论中提到了您" if noti[ "notification_type" ] == 6 
    return "回复了您的照片" if noti[ "notification_type" ] == 7 
    return "回复了您的评论" if noti[ "notification_type" ] == 8 
    return "刚在 #{ noti[ 'moment' ] [ 'name' ] } 中拍了照片" if noti[ "notification_type" ] == 9 
    return "刚在 #{ noti[ 'moment' ] [ 'name' ] } 中拍了视频" if noti[ "notification_type" ] == 10
    return "刚加入了 VIDA" if noti[ "notification_type" ] == 11
    return "邀请您在 #{ noti[ 'moment' ] [ 'name' ] } 中添加照片" if noti[ "notification_type" ] == 12
    return "也在使用 VIDA，赶紧关注吧！" if noti[ "notification_type" ] == 13 
    return "喜欢你的故事 #{ noti[ 'moment' ] [ 'name' ] }" if noti[ "notification_type" ] == 14
    return "回复了你的故事 #{ noti[ 'moment' ] [ 'name' ] }" if noti[ "notification_type" ] == 15
    return "关注了您" if noti[ "notification_type" ] == 51 
    return "希望关注您" if noti[ "notification_type" ] == 52
    return "" if noti[ "notification_type" ] == 99
  end

  def api_call( model , method , id , params )
    data = Moment .send( method , id , current_user , params ) if model == "Moment" 
    data = User   .send( method , id , current_user , params ) if model == "User" 
    session[ :cur_user ] [ :notification_count ] = data[ "notification_count" ] if current_user 
    data
  end
end
