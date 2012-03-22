class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id], 0, current_user)
    @user = User.fetch(params[:id])['data'].symbolize_keys
    save_url_in_cookies
  end

  def load_more
  	@moments = User.fetch_moments(params[:id], params[:page])
  end
end
