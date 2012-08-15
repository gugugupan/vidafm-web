require "VIDA"

PAGE_SIZE = 5

#encoding: utf-8
class Moment
  def self.recent
    JSON.parse(VIDA.call("moment/list_recent"))["data"]
  end

  def self.fetch(id, current_user , options = {})
    options.reject! { |key, value| value.nil? } # 清理为空的键值对，因为如果同时出现activity_id和page，服务器不认page。

    r = JSON.parse(VIDA.call("moment/show/#{id}?offset_padding=0&#{options.to_query}", nil, current_user ))
    r
  end
=begin
  def self.fetch_by_user_id(o = {})
    o = {
      :attender => o.delete(:user_id)
    }
    j = JSON.parse VIDA.call("moment/list?#{o.to_param}", nil, options[:current_user])
  end
=end
  def self.fetch_by_category( category , sort_type ) 
    JSON.parse VIDA.call( "moment/search?category=#{ category }&order=#{ sort_type }&limit=20" , nil )
  end

  def self.fetch_by_name( name , sort_type ) 
    JSON.parse VIDA.call( "moment/search?name=#{ name }&order=#{ sort_type }&limit=20" , nil )
  end

  def self.hot_story
    JSON.parse VIDA.call( "moment/list_featured" , { :limit => 20 } )
  end

  def self.share( current_user , options = {} )
    JSON.parse VIDA.call( "moment/share" , { :moment_id => options[ :id ] , :to => options[ :type ] , :content => options[ :content ] } , current_user )
  end

  def self.fetch_like_list( options = {} )
    JSON.parse VIDA.call( "like/list" , { :type => "Moment" , :type_id => options[ :id ] } )
  end
end
