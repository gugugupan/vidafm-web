require "VIDA"

class User
	class << self

		# 获取用户故事信息
		# Params
		# 	activity_ids[before]
		def fetch_moments( id , current_user , params )
			data = VIDA.call( "users/#{ id }/moments" , params , current_user , "GET" ) 
			data[ :body ] = "{\"data\":{\"moments\":[],\"next_query_parameters\":{}}}" if data[ :status ] == 401 || data[ :status ] == 204
			result = JSON.parse( data[ :body ] )
			result[ "data" ] [ "moments" ] .each do | moment | 
				moment[ "feed_type" ] = "activity_feed" 
				moment[ "created_at" ] = moment[ "moment" ] [ "modified_at" ] 
				moment[ "moment" ] [ "liked" ] = moment[ "liked" ]
			end
			result 
		end	

		def fetch_moments_category( user_id , category , current_user )
			return nil unless user_id =~ /[0-9]+/
			JSON.parse( VIDA.call( "moment/search?category=#{ category }&order=latest&user_id=#{ user_id }&limit=20" , nil ) [ :body ] )
		end

		# 获取用户信息
		def fetch( user_id , current_user , params )
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/
			data = VIDA.call( "users/#{ user_id }/brief" , {} , current_user , "GET" )
			res = JSON.parse( data[ :body ] )
			if data[ :status ] == 401 || data[ :status ] == 203
				res[ "status" ] = 401
			end
			res 
		end	

		# 获取用户feeds信息
		def fetch_feeds( id , current_user , params )
			JSON.parse( VIDA.call( "feeds" , params , current_user , "GET" ) [ :body ] )
		end

		# 获取当前登录用户信息
		def fetch_current_user( current_user )
			JSON.parse( VIDA.call( "user/brief" , {} , current_user ) [ :body ] )
		end

		# 关注 取消关注 移除粉丝
		#    status = [ follow unfollow remove agree reject ]
		def set_relation( user_id , current_user , commond )
			return nil unless user_id =~ /[0-9]+/
			data = VIDA.call( "relationships/#{ user_id }" , { :status => commond } , current_user , "PUT" )
			res = JSON.parse( data[ :body ] )
			res[ "status" ] = data[ :status ]
			res 
		end

		# 获取当前星用户
		def fetch_star_user( id , current_user , params )
			#JSON.parse( VIDA.call( "user/list_featured" , {} , current_user ) [ :body ] )
			JSON.parse( VIDA .call( "users/featured" , {} , current_user , "GET" ) [ :body ] )
		end

		# 获取用户关注或粉丝列表
		# 	type - [ "following" , "followers" ] 
		def fetch_follow( id , current_user , type , page )
			data = VIDA.call( "users/#{ id }/#{ type }" , { :page => page } , current_user , "GET" )
			data[ :body ] = "{\"data\":{\"users\":[]}}"if data[ :status ] == 204 
			JSON.parse( data[ :body ] )
		end

		# 获取用户喜欢、评论列表
		# Params : 
		# 	like_ids[before] 
		# 	comment_ids[before] (若为空则从头开始取)
		def fetch_commentlike( id , current_user , params )
			data = VIDA.call( "users/#{ id }/likes_and_comments" , params , current_user , "GET" )
			data[ :body ] = "{\"data\":{\"likes_and_comments\":[],\"next_query_parameters\":{}}}"if data[ :status ] == 204 
			JSON.parse( data[ :body ] )
		end
	end
end
