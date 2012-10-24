require "open-uri"
#encoding: utf-8
class DiscoverController < ApplicationController
  before_filter :save_url_in_cookies
  def index
    data = Moment.hot_story() [ "data" ]
    @official = data[ "public_moments" ]
  end

  def category
  	params[ :sort_type ] = "hottest" if params[ :sort_type ] .nil? || ( params[ :sort_type ] != "hottest" && params[ :sort_type ] != "latest" )
  	@moment = Moment.fetch_by_category( params[ :category ] , params[ :sort_type ] ) [ "data" ] [ "moments" ] 
  end

  def public
    params[ :sort_type ] = "latest" if params[ :sort_type ] .nil? || ( params[ :sort_type ] != "hottest" && params[ :sort_type ] != "latest" )
    @moment = Moment.fetch_by_name( params[ :name ] , params[ :sort_type ] ) [ "data" ] [ "moments" ]
  end

  def staruser
    @data = User.fetch_star_user( current_user ) [ "data" ]
    @data[ "recommended" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
    @data[ "stars" ] [ "users" ] .each { |u| u[ "relation_tag" ] = get_relation_btn( u[ "relation" ] ) }
  end
end
