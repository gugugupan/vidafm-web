#encoding: utf-8
class UsersController < ApplicationController  
  def show
    data = api_call( "User" , :fetch , params[ :id ] , nil )
    render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    @user = data[ "data" ] 
=begin
    @following_tag = get_relation_btn( @user[ :relation ] ) 
    if params[ :category ] .nil?
      data = User.fetch_moments(params[:id], 0, current_user)
      params[ :category ] = "all"
    else
      data = User.fetch_moments_category( params[ :id ] , params[ :category ] , current_user )
    end
    @result = notice #data[ "result" ]
    @result = 401 if @current_user && @user[ :following_limited ] == 1 && get_relation_btn( @user[ :relation ] ) != 1
    @moments = data[ "data" ]
    #data = User.fetch( params[:id] , current_user )
=end
    data = User.fetch_moments( params[ :id ] , current_user , {} ) [ "data" ]
    @feeds = data[ "moments" ] 
    @feeds .each do | moment | 
      moment[ "feed_type" ] = "activity_feed" 
      moment[ "created_at" ] = moment[ "moment" ] [ "modified_at" ] 
    end
    @qparams = data[ "next_query_parameters" ] 

    save_url_in_cookies
  end

=begin
  def ajax_following
    params[ :type ] = "following" if params[ :type ] .nil?
    result = User.set_relation( params[ :id ] , current_user , params[ :type ] )
    respond_to do |format|
      format .json { render :json => result }
    end
  end
=end

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
  def ajax_get_new_page
    case params[ :type ] 
    when "following" , "followers" 
      @user_list = User.fetch_follow( params[ :id ] , current_user , params[ :type ] , params[ :page ] ) [ "data" ] [ "users" ]
    when "commentlike" , "story"
      query = {
        "avtivity_ids[before]" => params[ :activity ] ,
        "comment_ids[before]" => params[ :comment ] ,
        "like_ids[before]" => params[ :like ] 
      }
      if params[ :type ] == "story" 
        data = User.fetch_moments( params[ :id ] , current_user , query ) [ "data" ]
        @feeds = data[ "moments" ]  
        @feeds .each { | moment | moment[ "feed_type" ] = "activity_feed" }
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
  #   type - "following" or "unfollow"
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
