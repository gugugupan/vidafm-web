class DiscoverController < ApplicationController
  def index
    @cur_user = current_user_for_header
  end

  def num2sort_type( num )
  	return "hottest" if num == 0
  	return "latest" if num == 1
  	return "nearest" if num == 2
  end

  #                         0 hottest
  # params[ :sort_type ] =  1 latest
  #                         2 nearest
  def category
  	if moment_category( params[ :category ] ) .nil?
  		render "discover/index" 
  		return 
  	end
  	params[ :sort_type ] = "hottest" if params[ :sort_type ] .nil?
    @cur_user = current_user_for_header
  	@moment = Moment.fetch_by_category( params[ :category ] , params[ :sort_type ] )  
  end
end
