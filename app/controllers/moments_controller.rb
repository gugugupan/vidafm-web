class MomentsController < ApplicationController
  before_filter :save_url_in_cookies
  def show
    params[ :page ] = "1" if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1

    data = Moment.fetch(params[ :id ] , :page => params[ :page ] , :page_size => 3 , :current_user => current_user)
    @max_page = data[ "page_count" ] + 1 
    @moment = data[ "data" ]
    @moment_cover = data[ "cover_file"]
    @cur_user = current_user_for_header
  end

  def ajax_get_new_page
    params[ :page ] = "1" if params[ :page ] .nil?
    params[ :page ] = params[ :page ] .to_i - 1

    @moment = Moment.fetch(params[ :id ] , :page => params[ :page ] , :page_size => 3 , :current_user => current_user) [ 'data' ] 
    render :layout => false
  end
end