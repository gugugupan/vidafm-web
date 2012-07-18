class DiscoverController < ApplicationController
  def index
    @cur_user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys if current_user
    save_url_in_cookies
  end

  def category
  	params[ :sort_type ] = "hottest" if params[ :sort_type ] .nil? || ( params[ :sort_type ] != "hottest" && params[ :sort_type ] != "latest" )
  	@moment = Moment.fetch_by_category( params[ :category ] , params[ :sort_type ] )
    @cur_user = User.fetch_current_user( current_user ) [ "data" ] .symbolize_keys if current_user

    save_url_in_cookies
  end
end
