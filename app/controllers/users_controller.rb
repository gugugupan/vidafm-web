class UsersController < ApplicationController
  
  def show
    @moments = User.fetch_moments(params[:id])
    @user = User.fetch(params[:id])['data']

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
