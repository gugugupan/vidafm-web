require "open-uri"
#encoding: utf-8
class DiscoverController < ApplicationController
  before_filter :save_url_in_cookies
  def index
    #data = Moment.hot_story() [ "data" ]
    data = api_call( "Moment" , :hot_story , nil , nil ) [ "data" ]
    @official = data[ "public_moments" ]
  end

  def category
  	params[ :sort_type ] = "hottest" if params[ :sort_type ] .nil? || ( params[ :sort_type ] != "hottest" && params[ :sort_type ] != "latest" )
  	#@moment = Moment.fetch_by_category( params[ :category ] , params[ :sort_type ] , 0 ) [ "data" ] [ "moments" ] 
    @moment = api_call( "Moment" , :fetch_by_category , nil , 
        { :category => params[ :category ] , :order => params[ :sort_type ] , :offset => 0 } 
    ) [ "data" ] [ "moments" ] 
  end

  def public
    params[ :sort_type ] = "latest" if params[ :sort_type ] .nil? || ( params[ :sort_type ] != "hottest" && params[ :sort_type ] != "latest" )
    #@moment = Moment.fetch_by_name( params[ :name ] , params[ :sort_type ] , 0 ) [ "data" ] [ "moments" ]
    data = api_call( "Moment" , :fetch_by_name , nil ,
        { :q => params[ :name ] , :order => params[ :sort_type ] , :offset => 0 }
    )
    @moment = data[ "data" ] [ "moments" ] 
    @description = data[ "data" ] [ "description" ] 
  end

  def staruser
    #@data = User.fetch_star_user( current_user ) [ "data" ]
    @data = api_call( "User" , :fetch_star_user , nil , nil ) [ "data" ]
    @data[ "recommended" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
    @data[ "stars" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
  end

  def ajax_get_new_page
    offset = ( params[ :page ] .to_i - 1 ) * 20 ;
    if params[ :action_name ] == "public"
      @moment = Moment.fetch_by_name( nil , nil ,
        { :q => params[ :name ] , :order => params[ :sort_type ] , :offset => offset }
      ) [ "data" ] [ "moments" ]
    else
      @moment = Moment.fetch_by_category( nil , nil ,
        { :category => params[ :category ] , :order => params[ :sort_type ] , :offset => offset } 
      ) [ "data" ] [ "moments" ] 
    end
    render :layout => false 
  end
end
