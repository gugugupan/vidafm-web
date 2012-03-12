class MomentsController < ApplicationController
  def show
    if request.url =~ /is_mobile=/i || request.user_agent =~ /(android|ipod|iphone)/i
       render :partial => "/misc/redirect", :layout => false 
       return
    end

    params[:page] = params[:page].to_i - 1 if params[:page]

    params[:page_size] = 6 if (params[:page_size].blank? or params[:page_size].to_i > 6)

    @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page], :page_size => params[:page_size], :current_user => current_user)
    @moment['current_page'] = 0 if @moment['current_page'].to_i == -1 # 如果没有找到activity，后台返回当前页数是-1 

    respond_to do |format|
      format.html
      format.js
    end
  end

  def map
    @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page], :page_size => 999)
  end

  def details
    # kActivitiesPerRow = 3
    # kRowPerPage = 2
    # photoNum = kActivitiesPerRow * kRowPerPage
    # @moment = Moment.fetch(params[:id], :activity_id => params[:activity_id], :page => params[:page].to_i - 1, :page_size => photoNum, :current_user => current_user)
  end
end