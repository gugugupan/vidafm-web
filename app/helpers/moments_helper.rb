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

	def moment_category( str )
		alph = {
			"random" => "随拍" ,
			"travel" => "出游" ,
			"children" => "亲子" ,
			"mood" => "心情日记" ,
			"food" => "吃货" ,
			"misc" => "其他" ,
			"all" => "所有故事分类" ,
			"hot" => "精选故事" ,
			"staruser" => "星用户" ,
			nil => "空" ,
		}
		return alph[ str ] || str
	end

	def empty_descripe( str )
		str = "(没有描述)" if str .nil? || str .length == 0
		str 
	end

	def time_ago_now( time_str )
		time_ago_in_words Time.parse( time_str )
	end
end
