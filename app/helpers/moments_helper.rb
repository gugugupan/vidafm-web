#encoding: utf-8
module MomentsHelper
	def vida_pagination(base_url, page_count, current_page, options)

	    page_count = page_count.to_i
		current_page = current_page.to_i + 1
		max_page_label = 6
		page_label_padding = options[:page_padding] || 2
		fixed_head_page_label = 2

		start_page = [current_page - page_label_padding, 1].max.to_i
		end_page = [start_page + page_label_padding * 2, page_count].min.to_i


		html = start_page.upto(end_page).inject("") do |a, e|
			a += page_label(base_url, e, current_page, options)
		end

		html = link_to("", "#{base_url}?page=1&page_size=#{options[:page_size]}", :class => "prev_page", :remote => options[:remote]) + raw(html) unless current_page == 1
		html = html + link_to("", "#{base_url}?page=#{page_count}&page_size=#{options[:page_size]}", :class => "next_page", :remote => options[:remote]) unless current_page == page_count

		raw html
	end

	def page_label(base_url, page, current_page, options)
		if page == current_page
			link_to(page, "#{base_url}?page=#{page}&page_size=#{options[:page_size]}", :class => "page_number current_page_number", :remote => options[:remote])
		else
			link_to(page, "#{base_url}?page=#{page}&page_size=#{options[:page_size]}", :class => :page_number, :remote => options[:remote])
		end
	end


	def google_image_tag activities
		base_url = "http://ditu.google.cn/maps/api/staticmap"
		locations = activities.reject { |e| e.symbolize_keys!; (e[:lat].to_f.abs < 0.01) or (e[:lng].to_f.abs < 0.01) }.map { |e| e.symbolize_keys!; "#{e[:lat]},#{e[:lng]}" if e[:lat] and e[:lng] }
		return if locations.count == 0
		options = {
			:size => "242x177", 
			:maptype => "roadmap",
			:markers => {
				"size" => "mid", 
				"color" => "red",
				"zlocations" => locations,
			},
			:zoom => "12", 
			:sensor => "false"
		}

		params = parse_options options

		image_tag "#{base_url}?#{params}", :alt => "moment_map"
	end


	def parse_options options
		options.symbolize_keys!
		if options[:markers]
			options[:markers] = options[:markers].to_a.sort { |a, b| a[0] <=> b[0] }.map do |e|
				if e[0] == "zlocations"
					e[1].join "|"
				else
					e.join ":"
				end
			end.join "|"
		end

		options.to_param
	end


	def user_avatar_or_placeholder current_user
		# return (image_tag current_user['avatar_file'], :class => "user-avatar") if current_user
		return (avatar_tag current_user) if current_user

		placeholder_url = "http://www.dentistry.co.uk/forum/forum_graphics/avatar_placeholder.gif"
		image_tag placeholder_url, :class => "user-avatar"
	end

	def vida_name
		"Vida 微图记 - 给照片新的定义"
	end

	def moment_category( str )
		alph = {
			"random" => "随拍" ,
			"travel" => "出游" ,
			"children" => "亲子" ,
			"mood" => "心情" ,
			"food" => "美食" ,
			"misc" => "其他" ,
			"all" => "所有故事分类" ,
			"hot" => "主题活动" ,
			"staruser" => "星用户" ,
			"photograph" => "摄影" ,
			nil => "空" ,
		}
		return alph[ str ] || str
	end

	def moment_category_by_num( num )
	    alph = {
	        "random" => 0,
	        "food" => 1,
	        "travel" => 2,
	        "children" => 3,
	        "mood" => 4,
	        "photography" => 6
	    } .invert
	    return moment_category( alph[ num ] )
	end

	def empty_descripe( str )
		str = "" if str .nil? || str .length == 0
		str 
	end

	def time_ago_now( time_str )
		return "" if time_str .nil?
		s = time_ago_in_words Time.parse( time_str )
		s = "1天" if s == "一天"
		s = "1小时" if s == "一小时"
		s = "1分钟" if s == "一分钟"
		s
	end

	def moment_name( item )
		item[ "name" ] = "" if item[ "name" ] .nil?
		if ( item[ "category" ] == "random" || item[ "category_id" ] == 0 ) and item[ "name" ] .empty?
			item[ "name" ] = "#{ item[ 'created_at' ] [ 5 , 2 ] }月#{ item[ 'created_at' ] [ 8 , 2 ]}日" 
		end
		item[ "name" ]
	end

	# get date string like 2010.10.5
	def moment_date( time )
		time = time .to_time
		"#{ time .year }.#{ time .month }.#{ time .day }"
	end

	def get_time( moment )
		time = "2000-01-01 08:00:00 AM UTC"
		time = moment[ "modified_at" ] unless moment[ "modified_at" ] .nil?
		time = moment[ "created_at" ] unless moment[ "created_at" ] .nil?
		time = moment[ "suggest_at" ] unless moment[ "suggest_at" ] .nil?
		time = time .to_time - 8 .hour
		time .to_s
	end

	# 将评论中行如 @Yukis(123456) 括号以及里面的数字去掉
=begin  This is wrong!!!
	def process_comment( comment )
		comment .sub( /@(.*)\|(.*)\([0-9]+\)/ , "@#{$2}" )
		comment .sub( /@(.*)\|(.*)\([0-9]+\)/ , "@#{$2}" )
	end
=end

	# 给feeds生成一个id
	def feed_id( feeds )
		case feeds[ "feed_type" ]
		when "activity_feed" then "moment#{ feeds[ "moment" ] [ "id" ] }"
		when "comment_feed" then "comment#{ feeds[ "type" ] == "activity" ? feeds[ "activity" ] [ "id" ] : feeds[ "moment" ] [ "id" ] }"
		when "like_feed" then "like#{ feeds[ "type" ] == "activity" ? feeds[ "activities" ] [ 0 ] [ "id" ] : feeds[ "moment" ] [ "id" ] }"
		end
	end

	# 将字符串中@weiboer|Akira-ming(1871901020)的内容变为@Akira-ming
	def express_comment( s )
		return "" if s .nil? 
		reg = /\@[a-zA-Z0-9\-]*\|([^(]*)\([\w]*\)/
		count = 0
		while !( s !~ reg ) do
			s = s .sub( reg , "@#{ $1 }" )
			break if ( count = count + 1 ) > 10
		end
		s
	end 
end
