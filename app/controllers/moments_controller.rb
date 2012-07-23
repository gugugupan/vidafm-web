class MomentsController < ApplicationController
  def show
    data = Moment.fetch(params[ :id ] , :page => 0 , :page_size => 3 , :current_user => current_user)
    @max_page = data[ "page_count" ] + 1 
    @moment = data[ "data" ]
    @moment_cover = @moment[ "cover_file" ]
    @cur_user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys if current_user
    
    save_url_in_cookies
  end

  def ajax_get_new_page
    return if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1
    @moment = Moment.fetch(params[ :id ] , :page => params[ :page ] , :page_size => 3 , :current_user => current_user) [ 'data' ] 
    render :layout => false
  end

  def ajax_like
    result = Activity.like( :activity_id => params[:id ] , :user => current_user )
    respond_to do |format|
      format .json { render :json => result }
    end
  end
end
