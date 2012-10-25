#encoding: utf-8
class UsersController < ApplicationController  
  def show
    data = User.fetch( params[:id] , current_user )
    render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    @user = data[ "data" ] .symbolize_keys
    @following_tag = get_relation_btn( @user[ :relation ] ) 
    if params[ :category ] .nil?
      data = User.fetch_moments(params[:id], 0, current_user)
      params[ :category ] = "all"
    else
      data = User.fetch_moments_category( params[ :id ] , params[ :category ] , current_user )
    end
    @result = notice #data[ "result" ]
    @moments = data[ "data" ]
    save_url_in_cookies
  end

  def friend
    redirect_to "/" and return unless current_user
    @user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys
    @moment = User.fetch_friend_moments( current_user ) [ "data" ]
    puts @moment .to_json
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

  def ajax_get_new_page
    return if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1
    @moments = User.fetch_moments(params[:id], params[ :page ], current_user) 
    render :layout => false
  end

  def following 
    if current_user 
      params[ :type ] = "following" if params[ :type ] .nil?
      @result = User.set_relation( params[ :id ] , current_user , params[ :type ] )
    else
      render "misc/need_authentication"
    end
  end
end
