#encoding: utf-8
class MiscController < ApplicationController
  def frontpage
    if request.url =~ /is_mobile=/i || request.user_agent =~ /(android|ipod|iphone)/i
      render :partial => "/misc/redirect", :layout => false 
      return
    end
    save_url_in_cookies
  end

  def about
    @feedback = Feedback.new
  end

  def create_feedback
    response = Feedback.create(params[:feedback])
    redirect_to :about, :notice => "感谢你的建议,我们将会尽快和你联系" if response['result'].to_i == 0
  end

  def android_download
  end

  def index
    redirect_to "/home" if current_user
    @moments = Moment.hot_story() [ "data"] [ "hottest_moments" ]
  end
=begin
  def ajax_new_comment
    return if params[ :comment_type ] .nil? || params[ :activity_id ] .nil? || params[ :content ] .nil?
    data = Comment.create( :comment_type => params[ :comment_type ] , :type_id => params[ :activity_id ] , :content => params[ :content ] , :user => current_user ) [ "comments" ]
    @comment = data[ data .size - 1 ]
    render :layout => false 
  end
=end
end
