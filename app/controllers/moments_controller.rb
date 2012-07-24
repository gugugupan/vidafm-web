class MomentsController < ApplicationController
  def show
    data = Moment.fetch(params[ :id ] , :page => 0 , :page_size => 3 , :current_user => current_user)
    @max_page = data[ "page_count" ] + 1 
    @moment = data[ "data" ]
    @moment_cover = @moment[ "cover_file" ]
    @cur_user = User.fetch_current_user( current_user )[ "data" ] .symbolize_keys if current_user
    
    save_url_in_cookies
  end

  def ajax_get_new_page
    return if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1
    @moment = Moment.fetch(params[ :id ] , :page => params[ :page ] , :page_size => 3 , :current_user => current_user) [ 'data' ] 
    render :layout => false
  end
=begin
  def ajax_like
    result = Activity.like( :activity_id => params[:id ] , :user => current_user )
    respond_to do |format|
      format .json { render :json => result }
    end
  end
=end
  def sharelist
    @sns_hash = {
      "weiboer" => { :name => "新浪微博" , :img => "images/icon_sina.png" , :url_attr => "?type=weibo" } ,
      "douban" => { :name => "豆瓣" , :img => "images/icon_douban.png" , :url_attr => "?type=douban" } ,
      "renren" => { :name => "人人" , :img => "images/icon_renren.png" , :url_attr => "?type=renren" } ,
      "kaixin001" => { :name => "开心" , :img => "images/icon_kaixin.png" , :url_attr => "?type=kaixin001" } ,
      "qq" => { :name => "腾讯微博" , :img => "images/icon_tencent.png" , :url_attr => "?type=qq" }
    }
    if current_user 
      @vendors = User.fetch_current_user( current_user )[ "data" ] [ "vendors" ]
    else
    end
  end

  def share
    if current_user
      @result = Moment.share( :id => params[ :id ] , :type => params[ :type ] , :content => params[ :content ] , :current_user => current_user )
    else
    end
  end
end
