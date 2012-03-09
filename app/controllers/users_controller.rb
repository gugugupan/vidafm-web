class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id], 0)
    @user = User.fetch(params[:id])['data'].symbolize_keys
  end

  def load_more
  	@moments = User.fetch_moments(params[:id], params[:page])
  end
end
