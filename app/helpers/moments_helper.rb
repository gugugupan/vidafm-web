module MomentsHelper
	def vida_pagination(base_url, page_count, current_page)

    page_count = page_count.to_i
		current_page = current_page.to_i + 1
		max_page_label = 6
		page_label_padding = 2
		fixed_head_page_label = 2

		html = ""

		if page_count == 1
			html += page_label(base_url, page_count, current_page)
		else
			html = 1.upto(2).inject(html) { |mem, var| mem += page_label(base_url, var, current_page) }   
			#=>   "< 1 2"
			html += "<span class='page-dot'> ... </span>" if current_page - fixed_head_page_label - page_label_padding > 1
			#=>   "< 1 2 .."

			html += [current_page - page_label_padding, 3].max.upto([current_page + page_label_padding, page_count].min).inject("") { |mem, var| mem += page_label(base_url, var, current_page) } 
			#=> 	"< 1 2 .. 4 5"

			
			html += "<span class='page-dot'> ... </span>" if current_page + page_label_padding < page_count
			#=>   "< 1 2 .. 4 5 .."
		end

		html = link_to("", "#{base_url}?page=#{current_page - 1}", :class => "prev_page") + raw(html) unless current_page == 1
		html = html + link_to("", "#{base_url}?page=#{current_page + 1}", :class => "next_page") unless current_page == page_count

		raw html
	end

	def page_label(base_url, page, current_page)
		if page == current_page
			link_to(page, "#{base_url}?page=#{page}", :class => "page_number current_page_number")
		else
			link_to(page, "#{base_url}?page=#{page}", :class => :page_number)
		end
	end


	def google_image_tag activities
		base_url = "http://maps.google.com/maps/api/staticmap"
		locations = activities.reject { |e| e.symbolize_keys!; (e[:lat].to_f < 0.01) or (e[:lng].to_f < 0.01) }.map { |e| e.symbolize_keys!; "#{e[:lat]},#{e[:lng]}" if e[:lat] and e[:lng] }
		options = {
			:size => "256x177", 
			:maptype => "roadmap",
			:markers => {
				:size => "mid", 
				:color => "red",
				:zlocations => locations 
			},
			:sensor => "false"
		}

		params = parse_options options

		image_tag "#{base_url}?#{params}", :alt => "moment_map"
	end


	def parse_options options
		options.symbolize_keys!
		if options[:markers]
			options[:markers] = options[:markers].to_a.map do |e|
				if e[0] == :zlocations
					e[1].join "|"
				else
					e.join ":"
				end
			end.join "|"
		end

		options.to_param
	end


	def user_avatar_or_placeholder current_user
		return (image_tag current_user['avatar_file'], :class => "user-avatar") if current_user

		placeholder_url = "http://www.dentistry.co.uk/forum/forum_graphics/avatar_placeholder.gif"
		image_tag placeholder_url, :class => "user-avatar"
	end


end