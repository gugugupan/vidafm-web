class ActivitiesController < ApplicationController
  def like
    @activity = Activity.like(:activity_id => params[:id], :user => current_user)
  end

  def likelist
  	@activities = Activity.fetchLikeList(params[:id])
  end

  def show
  	kMomentID = 13666
  	kActivityID = 29510
  	@moment = Moment.fetch(kMomentID, :activity_id => kActivityID, :page => params[:page], :page_size => 4)
    @moment['current_page'] = 0 if @moment['current_page'].to_i == -1 # 如果没有找到activity，后台返回当前页数是-1
    @activity = Object.new
    @moment['data']['items'].each do |e|
  		if e['id'] == kActivityID
  			@activity = e
  			break
  		end
    end
  end

end