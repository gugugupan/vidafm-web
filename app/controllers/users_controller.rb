class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id])
    @user = User.fetch(params[:id])['data']
  end
end
