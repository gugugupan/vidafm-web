#encoding: utf-8
class UsersController < ApplicationController  
  def show
    #data = User.fetch( params[:id] , current_user )
    data = api_call( "User" , :fetch , params[ :id ] , nil )
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
    @result = 401 if @current_user && @user[ :following_limited ] == 1 && get_relation_btn( @user[ :relation ] ) != 1
    @moments = data[ "data" ]
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
