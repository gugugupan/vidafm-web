class ActivitiesController < ApplicationController
  def like
    unless current_user
      render "comments/need_authentication"
    else
      @activity = Activity.like(:activity_id => params[:id], :user => current_user)
    end
  end

  def likelist
  	@activities = Activity.fetchLikeList(params[:id])
  end

  def show
  	kActivityID = params[:id]
  	@moment = Moment.fetch(nil, :activity_id => kActivityID, :page => params[:page], :page_size => 4, :current_user => current_user)
    raise ActiveRecord::RecordNotFound if  @moment['result'].to_i == 1
    @moment['current_page'] = 0 if @moment['current_page'].to_i == -1 # 如果没有找到activity，后台返回当前页数是-1
    redirect_to(user_url(@moment['data']['user_id'])) and return if auth_failed(@moment)
    @activity = Object.new
    @moment['data']['items'].each do |e|
  		if e['id'].to_i == kActivityID.to_i
  			@activity = e
  			break
  		end
    end
  end

  def remove
    unless current_user
      render "comments/need_authentication"
    else
      @message = Activity.remove(:activity_id => params[:id], :user => current_user)
    end
  end

end