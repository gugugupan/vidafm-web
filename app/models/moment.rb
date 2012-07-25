require "VIDA"

PAGE_SIZE = 5

#encoding: utf-8
class Moment
  def self.recent
    JSON.parse(VIDA.call("moment/list_recent"))["data"]
  end

  def self.fetch(id, options = {})
    options.reject! { |key, value| value.nil? } # 清理为空的键值对，因为如果同时出现activity_id和page，服务器不认page。

    r = JSON.parse(VIDA.call("moment/show/#{id}?offset_padding=0&#{options.to_query}", nil, options[:current_user]))
    r
  end

  def self.fetch_by_user_id_and_year_and_month(options = {})
    o = {
      :attender => options[:user_id],
      :month => "#{options[:year]}-#{options[:month]}"
    }
    j = JSON.parse VIDA.call("moment/list?#{o.to_param}", nil, options[:current_user])
  end

  def self.fetch_by_user_id(o = {})
    o = {
      :attender => o.delete(:user_id)
    }
    j = JSON.parse VIDA.call("moment/list?#{o.to_param}", nil, options[:current_user])
  end

  def self.fetch_by_category( category , sort_type ) 
    JSON.parse VIDA.call( "moment/search?category=#{ category }&order=#{ sort_type }&limit=10" , nil )
  end

  def self.hot_story
    JSON.parse VIDA.call( "moment/list_featured" )
  end

  def self.share( options = {} )
    JSON.parse VIDA.call( "moment/share" , { :moment_id => options[ :id ] , :to => options[ :type ] , :content => options[ :content ] } , options[ :current_user ] )
  end
end
