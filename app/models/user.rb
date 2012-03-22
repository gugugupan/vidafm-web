class User
	class << self
		def fetch_moments(user_id, page, current_user)
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/

			JSON.parse VIDA.call("/moment/list", {:attender => user_id, :page => page}, current_user)
		end	

		def fetch(user_id)
			# check whether the user_id is a number.
			return nil unless user_id =~ /[0-9]+/

			JSON.parse VIDA.call("/user/show", {:id => user_id})
		end	
	end
end
