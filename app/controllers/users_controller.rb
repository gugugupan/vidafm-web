#encoding: utf-8
class UsersController < ApplicationController  
  def get_relation_btn( r ) 
    alph = {
      "none" => 0 , "followed_by" => 0 , "pending_approve" => 0 , "pending_ignore" => 0 , "suggest_follow" => 0 ,
      "following" => 1 , "favourite" => 1 , "two_way_following" => 1 ,
      "pending" => 2
    }
    return alph[ r ]
  end

  def show
    if params[ :category ] .nil?
      @moments = User.fetch_moments(params[:id], 0, current_user) if current_user
      params[ :category ] = "all"
    else
    end
    @user = User.fetch( params[:id] , current_user ) ["data"] .symbolize_keys
    @cur_user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys if current_user 
    @following_tag = get_relation_btn( @user[ :relation ] ) 

    save_url_in_cookies
  end

  def friend
    unless current_user
      redirect_to "/"
      return
    end
    @user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys
    @moment = User.fetch_friend_moments( current_user ) [ "data" ]
  end

  def ajax_following
    params[ :type ] = "following" if params[ :type ] .nil?
    result = User.set_relation( params[ :id ] , current_user , params[ :type ] )
    respond_to do |format|
      format .json { render :json => result }
    end
  end

  def ajax_following_list
    params[ :relation ] = "following" if params[ :relation ] .nil?
    @list = User.fetch_friends( params[ :id ] , params[ :relation ] , current_user ) [ "data" ]
    render :layout => false
  end
end
