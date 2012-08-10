class MomentsController < ApplicationController
  def show
    data = Moment.fetch(params[ :id ] , current_user , :page => 0 , :page_size => 3 )    
    render "misc/error" and return if data[ 'result' ] == 1 
    @moment = data[ "data" ]
    @moment_cover = @moment[ "cover_file" ]
    @need_show = ( @moment[ "description" ] != "" && !@moment[ "description" ] .nil? ) || @moment[ "location" ] != ""
    save_url_in_cookies
  end

  def ajax_get_new_page
    return if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1
    @moment = Moment.fetch(params[ :id ] , current_user , :page => params[ :page ] , :page_size => 3 ) [ 'data' ] 
    render :layout => false
  end

  def comment
    if current_user
      @result = Comment.create( :comment_type => "Moment" , :type_id => params[ :id ] , :content => params[ :content ] , :user => current_user )
    else
      render "misc/need_authentication"
    end
  end

  def allcomments 
    @comments = Comment.fetch( :type => "Moment" , :type_id => params[ :id ] ) [ "data" ]
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
      "weiboer" => { :name => "新浪微博" , :img => "icon/icon_sina.png" , :url_attr => "?type=weiboer" } ,
      "douban" => { :name => "豆瓣" , :img => "icon/icon_douban.png" , :url_attr => "?type=douban" } ,
      "renren" => { :name => "人人" , :img => "icon/icon_renren.png" , :url_attr => "?type=renren" } ,
      "kaixin001" => { :name => "开心" , :img => "icon/icon_kaixin.png" , :url_attr => "?type=kaixin001" } ,
      "qq" => { :name => "腾讯微博" , :img => "icon/icon_tencent.png" , :url_attr => "?type=qq" }
    }
    if current_user 
      @vendors = cur_user[ :vendors ]
    else
      render "misc/need_authentication"
    end
  end

  def share
    if current_user
      params[ :content ] += " http://vida.fm/moments/#{ params[ :id ] }"
      @result = Moment.share( current_user , :id => params[ :id ] , :type => params[ :type ] , :content => params[ :content ] )
    else
      render "misc/need_authentication"
    end
  end
end
