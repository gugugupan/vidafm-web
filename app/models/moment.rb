require "VIDA"

#encoding: utf-8
class Moment

  # 获取单个故事
  def self.fetch(id, current_user , options = {})
    options.reject! { |key, value| value.nil? } # 清理为空的键值对，因为如果同时出现activity_id和page，服务器不认page。
    JSON.parse( VIDA.call("moment/show/#{id}?offset_padding=0", options , current_user ) [ :body ] )
  end
 
  # 获取当前热门故事
  def self.hot_story( id , current_user , params ) 
    JSON.parse( VIDA.call( "moment/list_featured" , { :limit => 20 } , current_user ) [ :body ] )
  end

  # 通过特定参数搜索故事
  # id - useless
  # Params :
  #   category \ q - 只能有一个参数（按类别与按故事名称）
  #   order - sort type
  #   offset - 
  def self.fetch_by_search( id , current_user , params ) 
    JSON.parse( VIDA.call( "moment/search?limit=20" , params , current_user ) [ :body ] )
  end

  def self.share( current_user , options = {} )
    JSON.parse( VIDA.call( "moment/share" , { :moment_id => options[ :id ] , :to => options[ :type ] , :content => options[ :content ] } , current_user ) [ :body ] )
  end

  def self.fetch_like_list( options = {} )
    JSON.parse( VIDA.call( "like/list" , { :type => "Moment" , :type_id => options[ :id ] } ) [ :body ] )
  end

  def self.like( id , current_user , params )
    JSON.parse( VIDA.call( "like/add" , { :type=>"Moment" , :type_id => id } , current_user ) [ :body ] )
  end
end
