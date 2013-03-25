#encoding: utf-8
class UsersController < ApplicationController  
  def show
    data = api_call( "User" , :fetch , params[ :id ] , nil )
    render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    @user = data[ "data" ] 
    @status = data[ "status" ]
    @relation = @user[ "followed" ] ? 1 : 0
    @relation = nil if @user[ "followed" ] .nil? || ( cur_user && params[ :id ] .to_i == cur_user[ :id ] .to_i ) || !current_user

    data = User.fetch_moments( params[ :id ] , current_user , {} ) [ "data" ]
    @feeds = data[ "moments" ] 
    @qparams = data[ "next_query_parameters" ] 

    save_url_in_cookies
  end

  def ajax_following_list
    params[ :relation ] = "following" if params[ :relation ] .nil?
    @list = User.fetch_friends( params[ :id ] , params[ :relation ] , current_user ) [ "data" ]
    render :layout => false
  end

  # Usage :
  #   get new page in ME page
  # Param :
  #   type - [ "story" , "commentlike" , "following" , "followers" ]
  #   id - user id
  #   page - finding for which page
  #   current - request user == current user?
  def ajax_get_new_page
    case params[ :type ] 
    when "following" , "followers" 
      data = User.fetch_follow( params[ :id ] , current_user , params[ :type ], params[ :page ] ) [ "data" ]
      @user_list = data[ "users" ] 
      @user_agree = data[ "pending" ] 
    when "commentlike" , "story"
      query = {
        "activity_ids[before]" => params[ :activity ] ,
        "comment_ids[before]" => params[ :comment ] ,
        "like_ids[before]" => params[ :like ] 
      }
      if params[ :type ] == "story" 
        data = User.fetch_moments( params[ :id ] , current_user , query ) [ "data" ]
        @feeds = data[ "moments" ]
      else 
        data = User.fetch_commentlike( params[ :id ] , current_user , query ) [ "data" ]
        @feeds = data[ "likes_and_comments" ]
      end
      @qparams = data[ "next_query_parameters" ] 
      @qparams[ "activity_ids" ] = { "before" => params[ :activity ] } if @qparams[ "activity_ids" ] .nil?
      @qparams[ "comment_ids" ] = { "before" => params[ :comment ] } if @qparams[ "comment_ids" ] .nil?
      @qparams[ "like_ids" ] = { "before" => params[ :like ] } if @qparams[ "like_ids" ] .nil?
    end
    render :layout => false
  end

  # Usage :
  #   following somebody
  # Param :
  #   type - "following" or "unfollow" or "remove"
  #   id - following user id 
  def following
    if current_user 
      params[ :type ] = "following" if params[ :type ] .nil?
      @result = User.set_relation( params[ :id ] , current_user , params[ :type ] )
      render :layout => false
    else
      render "misc/need_authentication"
    end
  end
end
