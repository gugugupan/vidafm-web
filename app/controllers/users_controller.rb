#encoding: utf-8
class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id], 0, current_user)
    @user = User.fetch(params[:id])['data'].symbolize_keys
    save_url_in_cookies
  end

  def load_more
  	@moments = User.fetch_moments(params[:id], params[:page], current_user)
  end

  def relation
  	trans = {
  		'followings' => 'following',
  		'followers'	 => 'followed_by',
  	}
  	relation = trans[params[:relation]]
  	@friends = User.fetch_friends(params[:id], relation, current_user)['data']
  	puts @friends
  end
end
