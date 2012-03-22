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

		inner_html = ""
		inner_html += image_tag "moments/details/avatar_shadow_white.png", :class => "user-avatar-shadow" if options[:shadow_white]
		inner_html += image_tag "moments/details/avatar_shadow.png", :class => "user-avatar-shadow" if options[:shadow]
		inner_html += image_tag user[:avatar_file], :class => 'user-avatar', :alt => user[:name], :title => user[:name]
		if user[:id] and not options[:nolink]
			link_to user_url(user[:id]), :class => 'user-avatar-link' do
				raw inner_html	
			end
		else
			raw inner_html
		end
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
end
