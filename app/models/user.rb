require "VIDA"

class User
	class << self

		# 获取用户故事信息
		# Params
		# 	activity_ids[before]
		def fetch_moments( id , current_user , params )
			JSON.parse( VIDA.call( "users/#{ id }/moments" , params , current_user , "GET" ) )
		end	

		def fetch_moments_category( user_id , category , current_user )
			return nil unless user_id =~ /[0-9]+/
			JSON.parse VIDA.call( "moment/search?category=#{ category }&order=latest&user_id=#{ user_id }&limit=20" , nil )
		end

		# 获取用户信息
		def fetch( user_id , current_user , params )
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/
			JSON.parse VIDA.call( "users/#{ user_id }/brief" , {} , current_user , "GET" )
		end	

		def fetch_friends(user_id, relations, current_user)
			return nil unless user_id =~ /[0-9]+/
			relations += ',favourite' if (relations == 'following' and user_id.to_i == (current_user['id'] || current_user[:id]).to_i)
			JSON.parse VIDA.call("user/relationships", {:id => user_id, :type => relations}, current_user)
		end

		# 获取用户feeds信息
		def fetch_friend_moments( id , current_user , params )
			JSON.parse VIDA.call( "feeds" , params , current_user , "GET" )
		end

		def fetch_current_user( current_user )
			JSON.parse VIDA.call( "user/brief" , {} , current_user )
		end

		def set_relation( user_id , current_user , commond )
			return nil unless user_id =~ /[0-9]+/
			JSON.parse VIDA.call( "user/set_relation" , { :user_id => user_id , :type => commond } , current_user )
		end

		def fetch_star_user( id , current_user , params )
			JSON.parse VIDA.call( "user/list_featured" , {} , current_user )
		end

		# 获取用户关注或粉丝列表
		# 	type - [ "following" , "followers" ] 
		def fetch_follow( id , current_user , type , page )
			JSON.parse( VIDA.call( "users/#{ id }/#{ type }" , { :page => page } , current_user , "GET" ) )
		end

		# 获取用户喜欢、评论列表
		# Params : 
		# 	like_ids[before] 
		# 	comment_ids[before] (若为空则从头开始取)
		def fetch_commentlike( id , current_user , params )
			JSON.parse( VIDA.call( "users/#{ id }/likes_and_comments" , params , current_user , "GET" ) )
		end
	end
end
