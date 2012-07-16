#encoding: utf-8
class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id], 0, current_user)
    @user = User.fetch(params[:id])['data'].symbolize_keys
    @cur_user = current_user_for_header
  end

  def friend
    unless current_user
      render "/"
      return
    end
    @user = User.fetch_current_user( current_user ) [ "data" ]
    @moment = User.fetch_friend_moments( current_user ) [ "data" ]
  end
end
