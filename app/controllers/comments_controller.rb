class CommentsController < ApplicationController
  def create
  	if not current_user
  		render "need_authentication"
  	else
	    @activity = Comment.create(:activity_id => params[:activity_id], :content => params[:content], :user => current_user) # 创建完评论返回评论相对应的activity，但是comment只返回最后五个。


      # 防止冲突。返回提交参数对象用作渲染。
      @comment = {
        "user" => current_user,
        "content" => params[:content],
        "created_at" => Time.now.to_s,
      }
	  end
  end

  def index
    @comments = Comment.fetchPeer(:activity_id => params[:activity_id])
  end
end