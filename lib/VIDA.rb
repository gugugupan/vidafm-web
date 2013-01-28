class VIDA
	class << self
		def call(methods, *options)
			params = options[0]
			user = options[1].try(:symbolize_keys)
			html_method = options[ 2 ] 
			html_method = "POST" if html_method .nil?
			resource = "#{ dev_api_url }/#{ methods }"
			cmd = case html_method
			when "GET"
				resource += "?#{ params .to_param }"
				"curl -A 'Platform/web' "
			when "POST"
				"curl -A 'Platform/web' -d " + '"' + "#{params.to_param}" + '" '
			end
			cmd += "-s "
			cmd += "-u #{user[:token]}:#{user[:secret]} " if user
			cmd += "'#{ resource }'"
			puts "\nCMD:#{cmd}\n"
			`#{cmd}`
		end

		def api_url
			"http://api2.vida.fm:15097"
		end

		def dev_api_url
			"http://elbrus.vida.fm:15097"
		end
	end
end
