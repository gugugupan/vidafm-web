module UsersHelper
	# @params: 
	# 	date: 2012-01-01 00:00:00 +0800 
	# @return: ['2012', '01']
	def year_and_month_of date
		exact_time_parts(date)[0, 2]
	end


	# @params: 
	# 	date: 2012-01-01 00:00:00 +0800 
	# @return: '01'
	def day_of date
		exact_time_parts(date)[2]
	end


	# @params:
	# 	obj: {:avatar_file => 'http://example/avatar.png', :id => 133}
	#				 {'avatar_file' => 'http://example/avatar.png'}	
	# @return:
	#   "<a href='users/133' class='user-avatar'><img src='http://example/avatar.png' class='user-avatar-img'></img></a>"

	def avatar_tag user, options = {}
		user.symbolize_keys!
		inner_html = link_to( image_tag( user[ :avatar_file ], :class => 'avatar' ) , "/user/#{ user[ :id ] }" ) ;
		raw inner_html
	end

	def relation_in_zh(word)
		alph = {
			'followings' => '关注',
			'followers'  => '粉丝',
		}

		return alph[word]
	end

	private

	def exact_time_parts date
		date = date.to_s
		date.split(/[-\ \/:]/)
	end


	def is_owner_or_admin? activity
		return false unless @current_user
		user_id = (activity['user_id'] || activity[:user_id]).to_i
		(admin_ids << user_id).include? @current_user[:id].to_i
	end

	def admin_ids
		#(VIDA 唯达).id
		[169, ]
	end

	def get_name( user )
		return "" if user .nil?
		"#{ user[ :name ] || user[ "name" ] } - "
	end
end
