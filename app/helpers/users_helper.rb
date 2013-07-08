#!/bin/env ruby
# encoding: utf-8
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
		class_str = "avatar #{ options[ :class ] }"
		inner_html = link_to( image_tag( user[ :avatar_file ] ) , "/users/#{ user[ :id ] }" , 
			:class => class_str , 
			:title => user[ :name ] ,
			:style => "background-image:url('#{ user[ :avatar_file ] }');
				filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='#{ user[ :avatar_file ] }',sizingMethod='scale');" )
		inner_html = image_tag( user[ :avatar_file ] , :class => 'avatar' ) if options[ :nolink ]
		raw inner_html
	end

	# Params :
	# 	{ :class => "" , :style => "" }
	def avatar_tag_b user , options = {}
		user[ "avatar_file" ] = user[ :avatar_file ] if user[ "avatar_file" ] .nil?
		user[ "id" ] = user[ :id ] if user[ "id" ] .nil?
		user[ "name" ] = user[ :name ] if user[ "name" ] .nil?
		inner_html = link_to( "" , "/users/#{ user[ "id" ] }" , 
			:class => "avatar #{ options[ :class ] }" , 
			:style => "background-image:url('#{ user[ "avatar_file" ] }');
					filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='#{ user[ "avatar_file" ] }',sizingMethod='scale');" , # hack for ie
			:title => user[ "name" ] )
		raw inner_html
	end

    # @params:
    #   obj: {:avatar_file => 'http://example/avatar.png', :id => 133}
    #                {'avatar_file' => 'http://example/avatar.png'} 
    # @return:
    #   "<a href='users/133' class='user-avatar'><img src='http://example/avatar.png' class='user-avatar-img'></img></a>"
    # 没有链接

    def avatar_tag_weibo user, options = {}
        user.symbolize_keys!
        class_str = "avatar #{ options[ :class ] }"
        inner_html = link_to( image_tag( user[ :avatar_file ] ) , "javascript:void(0);" , 
            :class => class_str , 
            :title => user[ :name ] ,
            :style => "background-image:url('#{ user[ :avatar_file ] }');
                filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='#{ user[ :avatar_file ] }',sizingMethod='scale');" )
        inner_html = image_tag( user[ :avatar_file ] , :class => 'avatar' ) if options[ :nolink ]
        raw inner_html
    end

	# Params :
	# 	none
	def datebox_tag time # time str like "2012-10-18 11:03:08 AM UTC (2012-10-18 07:03:08 PM Local)"
		time = time .to_time
		inner_html = '<div class="float_datebox">
			<p class="month">' + time .year .to_s + '/' + time .month .to_s + '</p>
			<p class="day">' + time .day .to_s + '</p>
		</div>'
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
