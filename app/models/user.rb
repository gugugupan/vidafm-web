require "VIDA"

class User
	class << self
		def fetch_moments(user_id, page, current_user)
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/

			JSON.parse VIDA.call("/moment/list", {:attender => user_id, :page => page, :offset_padding => 0}, current_user)
		end	

		def fetch_moments_category( user_id , category , current_user )
			return nil unless user_id =~ /[0-9]+/
			JSON.parse VIDA.call( "moment/search?category=#{ category }&order=latest&user_id=#{ user_id }&limit=20" , nil )
		end

		def fetch( user_id , current_user , params )
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/

			JSON.parse VIDA.call("/user/show", {:id => user_id} , current_user )
		end	

		def fetch_friends(user_id, relations, current_user)
			return nil unless user_id =~ /[0-9]+/
			relations += ',favourite' if (relations == 'following' and user_id.to_i == (current_user['id'] || current_user[:id]).to_i)
			JSON.parse VIDA.call("/user/relationships", {:id => user_id, :type => relations}, current_user)
		end

		def fetch_friend_moments( id , current_user , params )
			JSON.parse VIDA.call( "moment/list_following" , params , current_user )
		end

		def fetch_current_user( current_user )
			JSON.parse VIDA.call( "/user/brief" , {} , current_user )
		end

		def set_relation( user_id , current_user , commond )
			return nil unless user_id =~ /[0-9]+/
			JSON.parse VIDA.call( "/user/set_relation" , { :user_id => user_id , :type => commond } , current_user )
		end

		def fetch_star_user( id , current_user , params )
			JSON.parse VIDA.call( "/user/list_featured" , {} , current_user )
		end
	end
end
