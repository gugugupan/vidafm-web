class Comment 

  def self.fetch(options = {})
  	o = {
  		:type => options[:type],
  		:type_id => options[:type_id], 
  	}
  	JSON.parse( VIDA.call("comment/list?#{o.to_param}") [ :body ] ) 
  end


  # 创建完评论返回评论相对应的activity，但是comment只返回最后五个。
  def self.create(options = {})
  	options[:user].symbolize_keys!
    data = VIDA.call( "comment/add", {
      :type => options[ :comment_type ], 
      :type_id => options[:type_id], 
      :content => options[:content]
    },options[ :user ] ) 
  	JSON.parse( data[ :body ] )
  end
end
