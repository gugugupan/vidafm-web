class MomentsController < ApplicationController
  def show
    if request.url =~ /is_mobile=/i || request.user_agent =~ /(android|ipod|iphone)/i
       render :partial => "/misc/redirect", :layout => false 
       return
    end
    @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page])
    @moment['current_page'] = 0 if @moment['current_page'].to_i == -1 # 如果没有找到activity，后台返回当前页数是-1 
  end

  def map
    @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page], :page_size => 999)
  end

  def details
    kActivitiesPerRow = 3
    kRowPerPage = 2
    photoNum = kActivitiesPerRow * kRowPerPage
    @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page].to_i - 1, :page_size => photoNum)
  end
end